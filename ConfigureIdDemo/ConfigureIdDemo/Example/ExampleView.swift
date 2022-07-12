//
//  ExampleView.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 07/06/2022.
//

import UIKit

class ExampleView: UIView {
    
    let viewerContainerView: UIView
    
    let buttonsStackView: UIStackView
    
    let firstExampleButton: UIButton = createChoiceButton(title: "2D")
    
    let secondExampleButton: UIButton = createChoiceButton(title: "3D")
    
    let thirdExampleButton: UIButton = createChoiceButton(title: "Update")
    
    let resetButton: UIButton = createChoiceButton(title: "Reset")
    
    init() {
        buttonsStackView = [firstExampleButton, secondExampleButton, thirdExampleButton]
            .stacked(
                axis: .horizontal,
                spacing: .constant(5),
                distribution: .fillEqually
            )
        
        viewerContainerView = UIView()
        
        super.init(frame: .zero)
        
        addSubviews()
        setConstraints()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension ExampleView {
    
    func addSubviews() {
        self.addSubview(buttonsStackView)
        self.addSubview(viewerContainerView)
        self.addSubview(resetButton)
        self.sendSubviewToBack(viewerContainerView)
    }
    
    func setConstraints() {
        buttonsStackView.distribution = .fillEqually
        
        [buttonsStackView, resetButton, firstExampleButton, secondExampleButton, thirdExampleButton, viewerContainerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buttonsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            buttonsStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            resetButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            resetButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            resetButton.widthAnchor.constraint(equalTo: firstExampleButton.widthAnchor),
            
            viewerContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            viewerContainerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            viewerContainerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0),
            viewerContainerView.topAnchor.constraint(equalTo: self.resetButton.bottomAnchor, constant: 5),
        ])
        
    }
}

fileprivate func createChoiceButton(title: String) -> UIButton {
    let button = UIButton()
    
    button.setTitle(title, for: .normal)
    button.backgroundColor = UIColor(hexString: "#2E415D")
    button.layer.cornerRadius = 7
    
    return button
}
