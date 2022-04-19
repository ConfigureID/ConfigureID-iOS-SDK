//
//  File.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

extension Request {
    
    struct Customer {
        
        static func products(customerId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/customers/\(customerId)/products"

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
            components.host = ConfigureID.environment.host
            components.path = "/headless/customers/\(customerId)/products/\(productId)"

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
            components.host = ConfigureID.environment.host
            components.path = "/headless/customers/\(customerId)/products/find-by-vendor-id/\(vendorId)"
            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
        
            return Request(method: .GET, urlComponents: components)
        }
    }
}
