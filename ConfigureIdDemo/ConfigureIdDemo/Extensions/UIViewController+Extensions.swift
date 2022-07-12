//
//  UIViewController+Extensions.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 10/07/2022.
//

import UIKit

public extension UIViewController {
    
    func load(viewController: UIViewController, intoView: UIView? = .none, insets: UIEdgeInsets = .zero) {
        let containerView: UIView = intoView ?? view
        self.addChild(viewController)
        viewController.view.loadInto(containerView: containerView, insets: insets)
        viewController.didMove(toParent: self)
    }

    func remove(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }

}
