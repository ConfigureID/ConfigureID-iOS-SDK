//
//  Visualizer.swift
//
//
//  Created by Francisco D. on 21/04/2022.
//

import Foundation
import WebKit
import Combine

public class Visualizer: UIView {
    
    let webView: WKWebView!
    
    public let url: URL
    
    public let onFinishedLoading: PassthroughSubject<(), Never>
    
    public init(url: URL) {
        webView = WKWebView()
        self.url = url
        self.onFinishedLoading = PassthroughSubject<(), Never>()
        super.init(frame: .zero)
        webView.navigationDelegate = self
        addSubviews()
        setConstraints()
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
    
    public func initConfigure(
        customerId: Int,
        productId: Int,
        environment: String?,
        workflow: String?
    ) {
        
        var js = "initConfigure({customer: \(customerId), product: \(productId)"
        
        if let environment = environment {
            js += ", environment: \"\(environment)\""
        }
        
        if let workflow = workflow {
            js += ", workflow: \"\(workflow)\""
        }
        
        js += "})"
        
        executeJSCode(js: js)
    }
    
    public func setRecipe(recipeValues: [RecipeValue]) {
        //        [{ ca: 1, av: 2}, {ca: 2, av: 3}]
        
        var recipeValuesJs: String = ""
        
        recipeValues.enumerated().forEach { (index, recipeValue) in
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
            
            if index == recipeValues.indices.last {
                recipeValuesJs += "]"
            } else {
                recipeValuesJs += ","
            }
        }
        
        let js = "setRecipe(\(recipeValuesJs))"
    
        executeJSCode(js: js)
    }
    
    private func executeJSCode(js: String) {
        print("JS query made: \(js)")
        self.webView.evaluateJavaScript(js, completionHandler: { answer, error in
            if let answer = answer {
                print("answer \(answer)")
            } else if let error = error {
                print("error \(error)")
            }
        })
    }
    
    private func load() {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }

}

extension Visualizer: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.onFinishedLoading.send(())
    }
}
