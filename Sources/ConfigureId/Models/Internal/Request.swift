//
//  Request.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

struct Request {
    
    enum Method: String {
        case POST
        case GET
        case PUT
        case PATCH
    }
    
    let method: Method
    private(set) var urlComponents: URLComponents
    
    let httpBody: Data?
    
    init(method: Request.Method, urlComponents: URLComponents, httpBody: Data? = nil) {
        self.method = method
        self.urlComponents = urlComponents
        self.httpBody = httpBody
        
        self.urlComponents.queryItems = urlComponents.queryItems?.filter { $0.value != nil }
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = urlComponents.url else {
            throw ConfigureIdError.invalidURL
        }
        
        guard let apiKey = ConfigureId.apiKey else {
            throw ConfigureIdError.notAuthenticated
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
}
