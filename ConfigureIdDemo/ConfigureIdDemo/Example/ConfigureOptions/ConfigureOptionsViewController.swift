//
//  File.swift
//  
//
//  Created by Francisco D. on 10/07/2022.
//

import UIKit
import Combine
import DropDown
import ConfigureId

struct OptionEntry: Equatable {
    let id: Int
    let name: String
    
    static var changeView: OptionEntry {
        return OptionEntry(
            id: 10,
            name: "view"
        )
    }
}

class Option {
    
    // Should we send this to the api or not
    let isInternalOption: Bool
    
    let optionName: OptionEntry
    
    let selectedOptionIndex: CurrentValueSubject<Int, Never>
    
    let availableOptions: [OptionEntry]
    
    var selectedOption: OptionEntry {
        return availableOptions[selectedOptionIndex.value]
    }
    
    var didChange: Bool {
        return selectedOptionIndex.value != initiallySelectedIndex
    }
    
    let initiallySelectedIndex: Int
    
    init(optionName: OptionEntry, availableOptions: [OptionEntry], selectedOptionIndex: Int, isInternalOption: Bool) {
        self.optionName = optionName
        self.availableOptions = availableOptions
        self.selectedOptionIndex = CurrentValueSubject(selectedOptionIndex)
        self.isInternalOption = isInternalOption
        self.initiallySelectedIndex = selectedOptionIndex
    }
}

class ConfigureOptionsViewModel {
    let options: [Option]
    
    let session: Session
    
    init(session: Session, options: [Option]) {
        self.options = options
        self.session = session
    }
    
}

class ConfigureOptionsViewController: UIViewController {
    let _view: ConfigureOptionsView
    
    let _viewModel: ConfigureOptionsViewModel
    
    var _cancellables: [AnyCancellable] = []
    
    let finishedInteraction: AnyPublisher<(), Never>
    
    let _finishedInteraction = PassthroughSubject<(), Never>()
    
    init(viewModel: ConfigureOptionsViewModel) {
        _view = ConfigureOptionsView(options: viewModel.options)
        _viewModel = viewModel
        finishedInteraction = _finishedInteraction.eraseToAnyPublisher()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
        
        _view.optionsTable.dataSource = self
        _view.optionsTable.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.optionsTable.reloadData()
        bindViewModel()
    }
    
    func bindViewModel() {
        Publishers.MergeMany(
            _viewModel
                .options
                .map { option in option.selectedOptionIndex.map { index in index != option.initiallySelectedIndex } }
        )
        .sink(receiveValue: { [weak self] changed in
            self?._view.optionsTable.reloadData()
            
            if (changed) {
                self?._view.confirmButton.setTitle("Confirm", for: .normal)
            } else {
                self?._view.confirmButton.setTitle("Cancel", for: .normal)
            }
        })
        .store(in: &_cancellables)
        
        let options$ = _view
            .confirmButton
            .publisher(for: .touchUpInside)
            .map { [unowned self] _ in
                self._viewModel.options
            }.share()
        
        // no option was selected
        options$
            .filter { $0.isEmpty }
            .map { _ in }
            .sink(receiveValue: { [weak self] _ in
                self?._finishedInteraction.send()
            })
            .store(in: &_cancellables)
        
        // If we only changed local options
        options$
            .filter { options in
                options
                    .filter { $0.didChange }
                    .allSatisfy { $0.isInternalOption }
            }
            .sink(receiveValue: { [weak self] _ in
                self?.updateInternalOptions()
                self?._finishedInteraction.send()
            })
            .store(in: &_cancellables)
        
        // Options we need to send to the API
        options$
            .filter { !$0.isEmpty }
            .map { [unowned self] options -> AnyPublisher<Session, Never> in
                
                let recipeAttributesUpdates = convertToUpdateRecipeAttributes(options: options)
                
                if recipeAttributesUpdates.isEmpty {
                    return Empty().eraseToAnyPublisher()
                }
                
                return updateRecipe(
                    sessionId: _viewModel.session.sessionId,
                    includeSummary: true,
                    updates: recipeAttributesUpdates
                )
                .catch { error -> AnyPublisher<Session, Never> in
                    print(error)
                    return Empty().eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
            }
            .switchToLatest()
            .handleEvents(receiveOutput: { [weak self] session in
                Context.shared.data = Context.shared.data.map { ConfigureIdData(data: $0, session: session) }
                self?.updateInternalOptions()
            })
            .sink(receiveValue: { [weak self] _ in
                self?._finishedInteraction.send()
            })
            .store(in: &_cancellables)
    }
    
    fileprivate func updateInternalOptions() {
        if let changeViewOption = _viewModel.options.first(where: { $0.optionName == OptionEntry.changeView }) {
            if changeViewOption.didChange {
                Context.shared.viewName.value = changeViewOption.selectedOption.name
            }
        }
    }
}

func convertToUpdateRecipeAttributes(options: [Option]) -> [UpdateRecipeAttributes] {
    return options.compactMap { option in
        if option.isInternalOption {
            return nil
        }
        
        if !option.didChange {
            return nil
        }
        
        let selectedOption = option.selectedOption
        return UpdateRecipeAttributes(
            op: "selectValue",
            configurableAttribute: .id(option.optionName.id),
            attributeValue: .id(selectedOption.id)
        )
    }
}

extension ConfigureOptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsTableViewCell.identifier) as? OptionsTableViewCell else {
            return UITableViewCell()
        }
        
        let option = _viewModel.options[indexPath.row]
        
        cell.optionNameLabel.text = option.optionName.name
        cell.optionValueLabel.text = option.selectedOption.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OptionsTableViewCell.rowHeight
    }
    
}

extension ConfigureOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dropDown = DropDown()
        let optionRow = _viewModel.options[indexPath.row]
        
        dropDown.dataSource = optionRow.availableOptions.map { $0.name }
        dropDown.anchorView = tableView.cellForRow(at: indexPath)!
        dropDown.selectRow(at: optionRow.selectedOptionIndex.value)
        dropDown.show()
        
        dropDown.selectionAction = { (index: Int, item: String) in
            optionRow.selectedOptionIndex.value = index
        }
    }
}
