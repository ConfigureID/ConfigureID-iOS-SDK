//
//  ProductViewer.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 05/06/2022.
//

import Foundation
import WebKit
import Combine
import ConfigureId

// TODO: Move inside framework
class URLViewer: UIView {
    
    let webView: WKWebView!
    
    let url: URL
    
    let whenLoaded: PassthroughSubject<(), Never>
    
    init(url: URL) {
        webView = WKWebView()
        self.url = url
        self.whenLoaded = PassthroughSubject<(), Never>()
        super.init(frame: .zero)
        webView.navigationDelegate = self
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
    
    func initConfigure(
        customerId: Int,
        productId: Int,
        environment: String?,
        workflow: String?
    ) {
        
        var js = "initConfigure({customer: \(customerId), product: \(productId)"
        
        if let environment = environment {
            js += ", environment: \(environment)"
        }
        
        if let workflow = workflow {
            js += ", workflow: \(workflow)"
        }
        
        js += "})"
        
        print("Product loaded: \(js)")
        
        self.webView.evaluateJavaScript(js, completionHandler: {
            print($0, $1)
        })
    }
    
    func setRecipe(recipeValues: [RecipeValue]) {
        //        [{ ca: 1, av: 2}, {ca: 2, av: 3}]
        
        var recipeValuesJs: String = ""
        
        let foo = recipeValues
        
        foo.enumerated().forEach { (index, recipeValue) in
            if index == recipeValues.indices.first {
                recipeValuesJs += "["
            }
            
            var av: String
            
            switch recipeValue.selectedAttribute {
            case .number(let value):
                av = "\(value)"
            case .object(let dictionary):
                av = ""
                Array(dictionary).forEach { (key, value) in
                    if (value == "") {
                        av += "{ \(key) : \"\(value)\" }"
                    }
                    
                }
            }
            
            recipeValuesJs += " { ca: \(recipeValue.configurableAttributeId), av: \(av) }"
            
            if index == foo.indices.last {
                recipeValuesJs += "]"
            } else {
                recipeValuesJs += ","
            }
        }
        
        let js = "setRecipe(\(recipeValuesJs))"
        
        print("JS query made: \(js)")
        
        self.webView.evaluateJavaScript(js, completionHandler: {
            print($0, $1)
        })
    }
    
    
    // TODO: Naming
    public func load() {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
//            //            let js = "updateText(\"hello\")"
////            let js = "changeView(\"back\")"
////            print("---> evaluateJavascript")
//            
//            let js = "initConfigure({customer: 1525, product: 20725})"
//            
////            let js = "initConfigure({customer: 1622, product: 24253, environment: 'prod', workflow: 'dev'})"
//            
////            let js = "initConfigure({customer: 1525, product: 20725, environment: 'prod', workflow: 'prod'})"
//            
//            print("Evaluate js...")
//             
//            self.webView.evaluateJavaScript(js, completionHandler: {
//                print($0, $1)
//            })
//        })
    }
    
}

extension URLViewer: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.whenLoaded.send(())
    }
}
