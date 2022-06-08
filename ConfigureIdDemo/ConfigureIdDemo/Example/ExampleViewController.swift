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
            .sessionPublisher
            .subscribe(on: DispatchQueue.main)
            .map { [unowned self] configureIdData in
                return self.loadNewViewer(configureIdData: configureIdData)
            }
            .switchToLatest()
            .sink(receiveValue: { (viewer: Visualizer) in
                print("Viewer loaded")
            })
            .store(in: &_cancellables)
        
        _viewModel
            .updatedRecipe
            .subscribe(on: DispatchQueue.main)
            .map { [unowned self] configureIdData -> AnyPublisher<(), Never> in
                if configureIdData.session.isWebGl {
                    self.currentViewer?.setRecipe(recipeValues: configureIdData.session.recipe)
                    return Just(()).eraseToAnyPublisher()
                } else {
                    return self.loadNewViewer(configureIdData: configureIdData).map { _ in }
                        .eraseToAnyPublisher()
                }
            }
            .sink(receiveValue: { _ in
                print("Updated recipe")
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
                        environment: nil,
                        workflow: nil
                    )
                })
                .map { _ in viewer }
                .eraseToAnyPublisher()
        }
        
        return Just(viewer).eraseToAnyPublisher()
    }
}

fileprivate func getUrl(session: Session) -> URL {
    if let imageURLs = session.imageUrls {
        let imageURL = imageURLs.onBust
        return URL(string: imageURL)!
    }
    
    if !session.isWebGl {
        fatalError("shouldn't reach here because product is not webgl but doesn't have images")
    }
    
    return URL(string: "https://cdn-webgl.fluidconfigure.com/configure-webgl-display/index.html")!
}
