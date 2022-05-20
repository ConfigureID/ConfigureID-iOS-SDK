//
//  Request+Customers.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

extension Request {
    
    struct Customer {
        
        static func products(customerId: Int, workflow: String?, vendorId: String?) throws -> Request {
            var components = URLComponents()
            components.scheme = "https"
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/customers/\(customerId)/products"

            components.queryItems = [
                URLQueryItem(name: "workflow", value: workflow),
                URLQueryItem(name: "vendorId", value: vendorId)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func productData(customerId: Int, productId: Int, workflow: String?) throws -> Request {
            var components = URLComponents()
            components.scheme = "https"
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/customers/\(customerId)/products/\(productId)"

            components.queryItems = [
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
    }
}
