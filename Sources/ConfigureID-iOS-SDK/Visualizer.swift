//
//  Visualizer.swift
//  
//
//  Created by Francisco D. on 21/04/2022.
//

import Foundation
import UIKit
import WebKit

public extension ConfigureID {
    
    // TODO: Documentation
    static func productView(url: URL) -> UIView {
        return URLViewer(url: url)
    }
    
}

public class URLViewer: UIView, WKNavigationDelegate {
    
    let webView: WKWebView!
    
    let url: URL
    
    public init(url: URL) {
        webView = WKWebView()
        self.url = url
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
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
    
}
