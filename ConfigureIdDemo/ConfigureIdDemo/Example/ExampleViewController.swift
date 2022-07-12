//
//  ExampleViewController.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 07/06/2022.
//

import UIKit
import Combine
import ConfigureId

class ExampleViewController: UIViewController {
    
    let _view: ExampleView
    
    let _viewModel: ExampleViewModel
    
    var _cancellables: [AnyCancellable] = []
    
    init() {
        _view = ExampleView()
        
        _viewModel = ExampleViewModel(
            selectedExample: _view.buttonsStackView
                .subviews
                .compactMap { return $0 as? UIButton }
                .enumerated()
                .map { (index: Int, button: UIButton) in
                    button
                    .publisher(for: .touchUpInside)
                    .map { _ in index } }
                .merged()
                .eraseToAnyPublisher()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ExampleView()
        _view.loadInto(containerView: self.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    // webgl -> Load new URLViewer
    // Image -> Load new URLViewer
    func bind() {
        _viewModel
            .exampleSelected
            .sink(receiveValue: { _ in
                print("Example tapped")
            })
            .store(in: &_cancellables)
        
        Context
            .shared
            .viewName
            .compactMap { $0 }
            .filter { _ in Context.shared.data?.session.isWebGl ?? false
            }
            .sink(receiveValue: { [weak self] viewName in
                if (Context.shared.data?.session.isWebGl ?? false) {
                    self?.currentViewer?.changeView(viewName: viewName)
                }
            })
            .store(in: &_cancellables)
        
        Context
            .shared
            .viewName
            .compactMap { $0 }
            .filter { _ in
                let isWebGl = Context.shared.data?.session.isWebGl ?? false
                
                return !isWebGl
            }
            .map { [unowned self] _ -> AnyPublisher<Visualizer, Never> in
                if let data = Context.shared.data {
                    return self.loadNewViewer(configureIdData: data).eraseToAnyPublisher()
                }
                return Empty().eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink(receiveValue: { _ in
                // If we changed the image we are rendering
                print("--> Updated view")
            })
            .store(in: &_cancellables)
        
        _view
            .resetButton
            .publisher(for: .touchUpInside)
            .map { _ -> AnyPublisher<Session, Never> in
                if let session = Context.shared.data?.session {
                    return resetSession(sessionId: session.sessionId)
                        .catch { error -> AnyPublisher<Session, Never> in
                            print(error)
                            return Empty().eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                }
                
                return Empty().eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink(receiveValue: { session in
                print("-> reset")
                if let data = Context.shared.data {
                    Context.shared.data = ConfigureIdData(data: data, session: session)
                }
            })
            .store(in: &_cancellables)
        
        Context
            .shared
            .$data
            .print()
            .compactMap { $0 }
            .subscribe(on: DispatchQueue.main)
            .withPrevious()
            .map { [unowned self] (configureIdData: (ConfigureIdData?, ConfigureIdData)) -> AnyPublisher<(), Never> in
                let (previousData, currentData) = configureIdData
                
//                Uncomment this part to debug attributes
//                let allValues = currentData.session.productJson.attributes.map {
//                    return "\(($0.id, $0.name)): \($0.values.map { ($0.id, $0.name) })\n"
//                }
//
//                let allSubAttributes = currentData.session.productJson.attributes
//                    .compactMap { $0.subAttributes }
//                    .flatMap { $0 }
//                    .map { (subAttribute: ProductJsonAttribute) in
//                        return "\((subAttribute.id, subAttribute.name)): \(subAttribute.values.map { ($0.id, $0.name) })\n"
//                    }
//
//
//                allValues.forEach { print($0) }
//                allSubAttributes.forEach { print($0) }
          
                // If product is 3D and session is the same:
                    // setRecipe on viewer

                // otherwise:
                    // If we didn't have data
                    // the new session is different from the last session
                    // product is 2d.
                
                let sessionIsTheSame = previousData?.session.sessionId == currentData.session.sessionId
                let productIs3D = currentData.session.isWebGl
                
                if (sessionIsTheSame && productIs3D) {
                    self.currentViewer?.setRecipe(recipeValues: currentData.session.recipe)
                    return Just(()).eraseToAnyPublisher()
                }
                
                return self.loadNewViewer(configureIdData: currentData)
                        .map { _ in }
                        .eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink(receiveValue: { _ in
                print("Viewer loaded")
            })
            .store(in: &_cancellables)
        
        _viewModel
            .showOptionsMenu
            .subscribe(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { _ in
                self._view.buttonsStackView.isUserInteractionEnabled = false
            })
            .map { (data: ConfigureIdData) in
                createConfigureOptionsViewController(data: data)
            }
            .handleEvents(receiveOutput: { [weak self] (controller: ConfigureOptionsViewController) in
                self?.showOptionsMenu(configureOptionsViewController: controller)
            })
            .map { (controller: ConfigureOptionsViewController) -> AnyPublisher<(), Never> in
                controller
                    .finishedInteraction
                    .first()
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink(receiveValue: { [weak self] _ in
                self?.hideOptionsMenu()
                self?._view.buttonsStackView.isUserInteractionEnabled = true
            })
            .store(in: &_cancellables)

    }
    
    var currentViewer: Visualizer? {
        return self._view.viewerContainerView.subviews.first as? Visualizer
    }
    
    fileprivate func loadNewViewer(configureIdData: ConfigureIdData) -> AnyPublisher<Visualizer, Never> {
        if let oldViewer = currentViewer {
            oldViewer.removeFromSuperview()
        }
        
        let url = getUrl(session: configureIdData.session)
        let viewer = Visualizer(url: url)
        viewer.loadInto(containerView: self._view.viewerContainerView)
        

        if configureIdData.session.isWebGl {
            // If it's webgl, we need to wait until the page is rendered and call initConfigure.
            return viewer
                .onFinishedLoading
                .handleEvents(receiveOutput: { _ in
                    viewer.initConfigure(
                        customerId: configureIdData.customerId,
                        productId: configureIdData.productId,
                        environment: configureIdData.environment,
                        workflow: configureIdData.workflow
                    )
                })
                .map { _ in viewer }
                .eraseToAnyPublisher()
        }
        
        return Just(viewer).eraseToAnyPublisher()
    }
    
    fileprivate func showOptionsMenu(configureOptionsViewController: ConfigureOptionsViewController) {
        self.addChild(configureOptionsViewController)
        self.view.addSubview(configureOptionsViewController.view)
        
        NSLayoutConstraint.activate([
            configureOptionsViewController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            configureOptionsViewController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            configureOptionsViewController.view.widthAnchor.constraint(equalTo: self._view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    fileprivate func hideOptionsMenu() {
        let controllers = self.children.filter { $0 is ConfigureOptionsViewController }
        
        controllers.forEach {
            self.remove($0)
        }
    }
}
                    
fileprivate func createConfigureOptionsViewController(data: ConfigureIdData) -> ConfigureOptionsViewController {
    let options = createOptions(session: data.session)
    let configureOptionsViewModel = ConfigureOptionsViewModel(session: data.session, options: options)
    let configureOptionsViewController = ConfigureOptionsViewController(viewModel: configureOptionsViewModel)
    
    return configureOptionsViewController
}
                    
fileprivate func createOptions(session: Session) -> [Option] {
    let attributes = session.productJson.attributes
    let subAttributes = session.productJson.attributes.flatMap { $0.subAttributes ?? [] }
    
    let allAttributes = attributes + subAttributes
    
    var options: [Option] = allAttributes
        .filter { shouldShowAttribute(attribute: $0) }
        .compactMap { attribute in
            let allOptions = attribute.values.map { OptionEntry(id: $0.id, name: $0.name) }
            let _selectedOption = session.recipe.first(where: { $0.configurableAttributeId == attribute.id })?.selectedAttribute
            
            if allOptions.isEmpty {
                return nil
            }
            
            let selectedIndex: Int?
            
            switch _selectedOption {
            case .number(let id):
                selectedIndex = allOptions.firstIndex(where: { $0.id == id })
            default:
                selectedIndex = nil
            }
            
            return Option(
                optionName: OptionEntry(id: attribute.id, name: attribute.name),
                availableOptions: allOptions,
                selectedOptionIndex: selectedIndex ?? 0,
                isInternalOption: false
            )
        }
    
    if session.isWebGl {
        let views = Context.shared.available3DViews
        let defaultView = views.first
        let selectedView = Context.shared.viewName.value ?? defaultView
        let selectedIndex = selectedView.flatMap { views.firstIndex(of: $0) } ?? 0
        let viewOption = Option(
            optionName: OptionEntry.changeView,
            availableOptions: views.enumerated().map { OptionEntry(id: $0.offset, name: $0.element)
            },
            selectedOptionIndex: selectedIndex,
            isInternalOption: true
        )
        
        options.append(viewOption)
    } else {
        // Not webGL
        
        if let imageUrls = session.imageUrls {
            let selectedView = Context.shared.viewName.value
            let selectedIndex = imageUrls.enumerated().first(where: { $0.element.key == selectedView })
            let viewOption = Option(
                optionName: OptionEntry.changeView,
                availableOptions: imageUrls.enumerated().map { OptionEntry(id: $0.offset, name: $0.element.key) },
                selectedOptionIndex: selectedIndex?.offset ?? 0,
                isInternalOption: true
            )
            
            options.append(viewOption)
        }
    }
    
    return options
}

fileprivate func shouldShowAttribute(attribute: ProductJsonAttribute) -> Bool {
    let attributeList: [Int]
    
    switch Context.shared.data?.productId {
    case 23938:
        attributeList = [90069, 90070, 90068]
    case 24252:
        attributeList = [93755, 93776]
    case 23770:
        attributeList = [88191, 88195]
    case 21615:
        attributeList = [52163, 52170, 52164, 52165]
    default:
        attributeList = []
        break
    }
    
    if (attributeList.isEmpty) {
        return true
    }
    
    return attributeList.contains(attribute.id)
}

fileprivate func getUrl(session: Session) -> URL {
    if let imageURLs = session.imageUrls {
        if let viewName = Context.shared.viewName.value,
           let imageUrl = imageURLs[viewName]  {
            return URL(string: imageUrl)!
        }
        return imageURLs.first.flatMap { URL(string: $0.value) }!
    }
    
    if !session.isWebGl {
        fatalError("shouldn't reach here because product is not webgl but doesn't have images")
    }
    
    return URL(string: "https://cdn-webgl.fluidconfigure.com/configure-webgl-display/index.html")!
}
