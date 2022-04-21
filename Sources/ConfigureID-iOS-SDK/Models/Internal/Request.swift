//
//  File.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

struct Request {
    
    enum Method: String {
        case POST
        case GET
    }
    
    let method: Method
    let urlComponents: URLComponents
    
    let httpBody: Data?
    
    init(method: Request.Method, urlComponents: URLComponents, httpBody: Data? = nil) {
        self.method = method
        self.urlComponents = urlComponents
        self.httpBody = httpBody
    }
    
    func urlRequest() -> URLRequest? {
        guard let endpoint = urlComponents.url else {
            // TODO: Return an error
            fatalError("Ups!")
            return nil
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        
//        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "content-type")

        
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        return request
    }
}
