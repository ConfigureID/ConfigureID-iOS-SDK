//
//  File.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    // TODO: Documentation
    struct Customers {
        
        // TODO: Document
        // TODO: Does this returns an [product summary] or [Product]?
        public static func fetchProducts(customerId: Int, workflow: String, onSuccess: @escaping ([ProductSummary]) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            
            let request = Request.Customer.products(
                customerId: customerId,
                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                workflow: workflow
            )
            
            NetworkService
                .shared
                .executeRequest(
                    request: request,
                    onSuccess: onSuccess,
                    onError: onError
                )
        }
        
        // TODO: Document
        public static func fetchProductData(customerId: Int, productId: Int, workflow: String, onSuccess: @escaping (Product) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let request = Request.Customer.productData(
                customerId: customerId,
                productId: productId,
                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                workflow: workflow
            )
            
            NetworkService
                .shared
                .executeRequest(
                    request: request,
                    onSuccess: onSuccess,
                    onError: onError
                )
        }
        
        // TODO: Document
        public static func findByVendorId(customerId: Int, vendorId: String, workflow: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let request = Request.Customer.findByVendorId(
                customerId: customerId,
                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                vendorId: vendorId,
                workflow: workflow
            )
            
            NetworkService
                .shared
                .executeRequest(
                    request: request,
                    onSuccess: onSuccess,
                    onError: onError
                )
        }
    }
}
