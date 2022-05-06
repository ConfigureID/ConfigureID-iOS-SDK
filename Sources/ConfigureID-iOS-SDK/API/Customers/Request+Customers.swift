//
//  Request+Customers.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

extension Request {
    
    struct Customer {
        
        static func products(customerId: Int, workflow: String?) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/customers/\(customerId)/products"

            components.queryItems = [
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func productData(customerId: Int, productId: Int, workflow: String?) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/customers/\(customerId)/products/\(productId)"

            components.queryItems = [
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
//        static func findByVendorId(customerId: Int, vendorId: String, workflow: String) -> Request {
//            var components = URLComponents()
//            // TODO: allow to modify this
//            components.scheme = "https"
//            // TODO: allow to modify this
//            components.host = ConfigureID.environment.host
//            components.path = "/headless/customers/\(customerId)/products/find-by-vendor-id/\(vendorId)"
//            components.queryItems = [
//                URLQueryItem(name: "workflow", value: workflow)
//            ]
//        
//            return Request(method: .GET, urlComponents: components)
//        }
    }
}
