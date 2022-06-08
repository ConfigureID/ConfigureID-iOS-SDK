////
////  Visualizer.swift
////  
////
////  Created by Francisco D. on 21/04/2022.
////
//
//import Foundation
//import UIKit
//import WebKit
//
////public struct ViewerParameters {
////    public let customer: Int
////    public let product: Int
////    public let workflow: Int?
////    public let environment: Int?
////    public let recipe: Int?
////    //    Attribute and Attribute value list. E.g [{ ca: 1, av: 2}, {ca: 2, av: 3}]
////    // what is the type of this?
//////    let recipeValues
////}
//
//class URLViewer: UIView {
//    
//    let webView: WKWebView!
//    
//    let url: URL
//    
//    let whenLoaded: () -> ()
//    
//    init(url: URL, whenLoaded: @escaping () -> ()) {
//        webView = WKWebView()
//        self.url = url
//        self.whenLoaded = whenLoaded
//        super.init(frame: .zero)
//        webView.navigationDelegate = self
//        self.backgroundColor = .red
//        addSubviews()
//        setConstraints()
//        // TODO: do this on init?
//        self.load()
//    }
//    
//    func addSubviews() {
//        addSubview(webView)
//    }
//    
//    func setConstraints() {
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            webView.topAnchor.constraint(equalTo: self.topAnchor),
//            webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            webView.leftAnchor.constraint(equalTo: self.leftAnchor),
//            webView.rightAnchor.constraint(equalTo: self.rightAnchor),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // TODO: Naming
//    func load() {
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = false
//        
////        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
////            //            let js = "updateText(\"hello\")"
//////            let js = "changeView(\"back\")"
//////            print("---> evaluateJavascript")
////
////            let js = "initConfigure({customer: 1525, product: 20725})"
////
//////            let js = "initConfigure({customer: 1622, product: 24253, environment: 'prod', workflow: 'dev'})"
////
//////            let js = "initConfigure({customer: 1525, product: 20725, environment: 'prod', workflow: 'prod'})"
////
////            print("Evaluate js...")
////
////            self.webView.evaluateJavaScript(js, completionHandler: {
////                print($0, $1)
////            })
////        })
//    }
//    
//}
//
//extension URLViewer: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        self.whenLoaded()
//    }
//}
