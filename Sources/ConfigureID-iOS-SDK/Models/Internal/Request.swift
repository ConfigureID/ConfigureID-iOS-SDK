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
    
    func urlRequest() -> URLRequest? {
        guard let endpoint = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        return request
    }
}

extension Request {
    
    struct Customer {
        
        static func products(customerId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func productData(customerId: String, productId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products/\(productId)"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func findByVendorId(customerId: String, apiKey: String, vendorId: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products/find-by-vendor-id/\(vendorId)"
            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
        
            return Request(method: .GET, urlComponents: components)
        }
    }
    
}
