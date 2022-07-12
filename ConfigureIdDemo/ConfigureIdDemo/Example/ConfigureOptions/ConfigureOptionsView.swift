//
//  ConfigureOptionsView.swift
//  
//
//  Created by Francisco D. on 10/07/2022.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 60
    static let identifier = "OptionsTableViewCell"

    let optionNameLabel: UILabel = createOptionNameLabel()
    
    let optionValueLabel: UILabel = createOptionValueLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(optionNameLabel)
        self.contentView.addSubview(optionValueLabel)
    }
    
    func setConstraints() {
        [optionNameLabel, optionValueLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let labelsSeparation = optionValueLabel.leftAnchor.constraint(greaterThanOrEqualTo: optionNameLabel.rightAnchor, constant: 20)
        
        NSLayoutConstraint.activate([
            optionNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            optionValueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            optionNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            optionValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            labelsSeparation
        ])
    }
}

fileprivate func createOptionNameLabel() -> UILabel {
    let optionNameLabel = UILabel()
    
    return optionNameLabel
}

fileprivate func createOptionValueLabel() -> UILabel {
    let optionValueLabel = UILabel()
    
    return optionValueLabel
}

class ConfigureOptionsView: UIView {
    let optionsTable: UITableView = createTableView()
    let confirmButton = createConfirmButton()
    
    init(options: [Option]) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setConstraints(options: options)
        
        self.backgroundColor = UIColor(hexString: "#2E415D")
        self.layer.borderColor = UIColor(hexString: "#2E415D").cgColor
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 0.2
    }
    
    func addSubviews() {
        addSubview(optionsTable)
        addSubview(confirmButton)
    }
    
    func setConstraints(options: [Option]) {
        [optionsTable, confirmButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
//            self.heightAnchor.constraint(equalToConstant: 600),
            
            optionsTable.topAnchor.constraint(equalTo: self.topAnchor),
            optionsTable.leftAnchor.constraint(equalTo: self.leftAnchor),
            optionsTable.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.heightAnchor.constraint(equalToConstant: 4 * OptionsTableViewCell.rowHeight),
            
            confirmButton.topAnchor.constraint(equalTo: optionsTable.bottomAnchor),
            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func createTableView() -> UITableView {
    let tableView = UITableView()
    
    tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: OptionsTableViewCell.identifier)
    
    return tableView
}

func createConfirmButton() -> UIButton {
    let confirmButton = UIButton()
    
    confirmButton.setTitle("Cancel", for: .normal)
    
    return confirmButton
}
