//
//  Endpoints.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

struct Endpoints {
        
    // TODO: allow to modify this
    static let baseURL = "https://headless.fluidconfigure.com"
    
    struct Customer {
        
        static func products(customerId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            components.scheme = "https"
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
            components.scheme = "https"
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
            components.scheme = "https"
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

