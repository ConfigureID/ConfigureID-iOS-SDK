//
//  Visualizer.swift
//  
//
//  Created by Francisco D. on 21/04/2022.
//

import Foundation
import UIKit
import WebKit
//
//public class Visualizer: UIViewController {
//
//    var webView: WKWebView!
//
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
//}

public class ProductView: UIView {
    
    let webView: WKWebView!
    
    public init() {
        webView = WKWebView()
        super.init(frame: .zero)
        webView.navigationDelegate = self
        self.backgroundColor = .red
        addSubviews()
        setConstraints()
        // TODO: do this on init?
        self.load()
    }
    
    func addSubviews() {
        addSubview(webView)
    }
    
    func setConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: self.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: Naming
    public func load() {
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}

extension ProductView: WKNavigationDelegate {

}
