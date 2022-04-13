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
        
        public static func fetchProducts(customerId: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            CustomerEndpoints.fetchProducts(apiKey: try! apiKey.get(), customerId: customerId, onSuccess: onSuccess, onError: onError)
        }
        
        public static func fetchProductData(customerId: String, productId: String, onSuccess: @escaping (Product) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            CustomerEndpoints.fetchProductData(apiKey: try! apiKey.get(), customerId: customerId, productId: productId, onSuccess: onSuccess, onError: onError)
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
