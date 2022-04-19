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
    
    // TODO: Allow to change this?
    static let host: String = "headless.fluidconfigure.com"
//    static let host: String = "staging.fluidconfigure.com"
    
    
    func urlRequest() -> URLRequest? {
        guard let endpoint = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        return request
    }
}
