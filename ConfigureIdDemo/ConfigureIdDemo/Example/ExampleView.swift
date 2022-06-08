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
    
    let firstExampleButton: UIButton = createChoiceButton(title: "Image")
    
    let secondExampleButton: UIButton = createChoiceButton(title: "webGL")
    
    let thirdExampleButton: UIButton = createChoiceButton(title: "update")
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension ExampleView {
    
    func addSubviews() {
        self.addSubview(buttonsStackView)
        self.addSubview(viewerContainerView)
        self.sendSubviewToBack(viewerContainerView)
    }
    
    func setConstraints() {
        buttonsStackView.distribution = .fillEqually
        
        [buttonsStackView, firstExampleButton, secondExampleButton, thirdExampleButton, viewerContainerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buttonsStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            buttonsStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            viewerContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            viewerContainerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            viewerContainerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0),
            viewerContainerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
        ])
        
    }
}

fileprivate func createChoiceButton(title: String) -> UIButton {
    let button = UIButton()
    
    button.setTitle(title, for: .normal)
    button.backgroundColor = .red
    
    return button
}
