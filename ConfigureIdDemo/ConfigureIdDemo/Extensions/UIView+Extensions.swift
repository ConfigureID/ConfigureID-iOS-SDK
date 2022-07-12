//
//  UIView+Extensions.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 05/06/2022.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

public extension UIView {
    
    func loadInto(containerView: UIView, insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: insets.left)
        ]
        
        constraints.forEach { $0.priority = priority }
        NSLayoutConstraint.activate(constraints)
    }
}

public enum SpacingType {
    case constant(CGFloat)
    case customSpacingAfterView([UIView: CGFloat])
}

public extension Array where Element: UIView {
    
    @available(iOS 11.0, *)
    func stacked(
        axis: NSLayoutConstraint.Axis,
        spacing: SpacingType?,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill) -> UIStackView {
            self.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            let stackView = UIStackView(arrangedSubviews: self)
            stackView.axis = axis
            stackView.distribution = distribution
            stackView.alignment = alignment
            
            if let spacing = spacing {
                
                switch spacing {
                case .constant(let spacing):
                    stackView.spacing = spacing
                case .customSpacingAfterView(let viewsAndSpacing):
                    viewsAndSpacing.forEach { key, value in
                        stackView.setCustomSpacing(value, after: key)
                    }
                }
            }
            
            return stackView
        }
    
}
