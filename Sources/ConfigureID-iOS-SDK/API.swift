//
//  API.swift
//  
//
//  Created by Francisco D. on 13/04/2022.
//

import Foundation

// TODO: Documentation
public struct ConfigureID {
    
    // TODO: Documentation
    private static var apiKey: String?
    
    // TODO: is this ok?
    init(apiKey: String) {
        ConfigureID.setApiKey(apiKey: apiKey)
    }
    
    public static func setApiKey(apiKey: String) {
        ConfigureID.apiKey = apiKey
    }
    
}

public extension ConfigureID {
    
    struct Customers {
        
        // TODO: Document
        // TODO: Does this returns an [product summary] or [Product]?
        public static func fetchProducts(customerId: String, workflow: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            
            let endpoint = Endpoints.Customer.products(
                customerId: customerId,
                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                workflow: workflow
            )
            
            // TODO: Unwrap
            let request = URLRequest(url: endpoint!)
            
            NetworkService
                .shared
                .executeRequest(
                    urlRequest: request,
                    onSuccess: onSuccess,
                    onError: onError
                )
        }
        
        // TODO: Document
        public static func fetchProductData(customerId: String, productId: String, workflow: String, onSuccess: @escaping (Product) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let endpoint = Endpoints.Customer.productData(
                customerId: customerId,
                productId: productId,
                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                workflow: workflow
            )
            
            // TODO: Unwrap
            let request = URLRequest(url: endpoint!)
            
            
            NetworkService
                .shared
                .executeRequest(
                    // TODO
                    urlRequest: request,
                    onSuccess: onSuccess,
                    onError: onError
                )
        }
        
        // TODO: Document
        public static func findByVendorId(customerId: String, vendorId: String, workflow: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let endpoint = Endpoints.Customer.findByVendorId(
                customerId: customerId,
                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                vendorId: vendorId,
                workflow: workflow
            )
            
            // TODO: Optional
            let urlRequest = URLRequest(url: endpoint!)
            
            NetworkService
                .shared
                .executeRequest(
                    urlRequest: urlRequest,
                    onSuccess: onSuccess,
                    onError: onError
                )
        }
    
    }
}

private extension ConfigureID {
    static func ensureApiKey() -> Result<String, Error> {
        // TODO: Return error on no api key
        guard let apiKey = ConfigureID.apiKey else {
            fatalError("TODO: return an error")
        }
        
        return .success(apiKey)
    }
}


