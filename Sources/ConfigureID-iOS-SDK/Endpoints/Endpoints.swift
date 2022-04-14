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
        
        static func products(customerId: String, apiKey: String, workflow: String) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return components.url
        }
        
        static func productData(customerId: String, productId: String, apiKey: String, workflow: String) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products/\(productId)"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return components.url
        }
        
        static func findByVendorId(customerId: String, apiKey: String, vendorId: String, workflow: String) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products/find-by-vendor-id/\(vendorId)"
            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
        
            return components.url
        }
    }
}

// TODO: Maybe we don't need this class
public struct CustomerEndpoints {
    
    // TODO: Document
    static func fetchProducts(apiKey: String, customerId: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
        let endpoint = Endpoints.Customer.products(
            customerId: customerId,
            apiKey: apiKey,
            // TODO: send as parameter
            workflow: "dev"
        )
        
        NetworkService
            .shared
            .GET(
                // TODO
                url: endpoint!,
                onSuccess: onSuccess,
                onError: onError
            )
    }
    
//    // TODO: Document
//    static func fetchProductData(apiKey: String, customerId: String, productId: String, onSuccess: @escaping (Product) -> (), onError: @escaping (Error) -> ()) {
//        let endpoint = Endpoints.Customer.productData(
//            customerId: customerId,
//            productId: productId,
//            // TODO: send as parameter
//            apiKey: "<API_KEY>",
//            // TODO: send as parameter
//            workflow: "dev"
//        )
//        
//        NetworkService
//            .shared
//            .GET(
//                url: endpoint!,
//                onSuccess: onSuccess,
//                onError: onError
//            )
//    }
}
