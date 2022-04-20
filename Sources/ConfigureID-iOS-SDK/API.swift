//
//  API.swift
//  
//
//  Created by Francisco D. on 13/04/2022.
//

import Foundation


// TODO: Allow to change host?
enum Environment: String {
    case prod
    case staging
    
    var host: String {
        switch self {
        case .prod:
            return "prod-ingress.fluidconfigure.com"
        case .staging:
            return "staging-ingress.fluidconfigure.com"
        }
    }
    
    static var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    static var decoder: JSONDecoder {
        return JSONDecoder()
    }
}

// TODO: Documentation
public struct ConfigureID {
    
    // TODO: Documentation
    private static var apiKey: String?
    
    static var environment: Environment = .prod
    
    // TODO: is this ok?
    init(apiKey: String) {
        ConfigureID.setApiKey(apiKey: apiKey)
    }
    
    public static func setApiKey(apiKey: String) {
        ConfigureID.apiKey = apiKey
    }
}

public extension ConfigureID {
    
    // TODO: Documentation
    struct Customers {
        
        // TODO: Document
        // TODO: Does this returns an [product summary] or [Product]?
        public static func fetchProducts(customerId: Int, workflow: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
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
    
    struct Sessions {
        
        // TODO: Document
        public static func fetchSession(sessionId: String, workflow: String, onSuccess: @escaping (Session) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let request = Request.Sessions.session(
                sessionId: sessionId,
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
        public static func createSession(
            parameters: CreateSessionParameters,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (Error) -> ()
        ) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            do {
                let request = try Request.Sessions.createSession(
                    // TODO: Check Api key
                    apiKey: try! apiKey.get(),
                    parameters: parameters
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                // TODO: move this out
                fatalError("Error occurred get: \(error)")
            }
        }
    }
    
    struct Recipes {
        
        // TODO: Add locale, includeLocalizedConfiguration, includeExtendedAttributes, etc...
        public static func fetchRecipe(recipeId: String, workflow: String, onSuccess: @escaping (Recipe) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
//            let request = Request.Sessions.session(
//                sessionId: recipeId,
//                // TODO: Check Api key
//                apiKey: try! apiKey.get(),
//                workflow: workflow
//            )
//
//            NetworkService
//                .shared
//                .executeRequest(
//                    request: request,
//                    onSuccess: onSuccess,
//                    onError: onError
//                )
        }
        
        // TODO: remove parameters and add them to the function
        public static func createRecipe(parameters: CreateRecipeParameters, onSuccess: @escaping (Recipe) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let request = Request.Recipes.createRecipe(
                //                // TODO: Check Api key
                apiKey: try! apiKey.get(),
                parameters: parameters
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

private extension ConfigureID {
    static func ensureApiKey() -> Result<String, Error> {
        // TODO: Return error on no api key
        guard let apiKey = ConfigureID.apiKey else {
            fatalError("TODO: return an error")
        }
        
        return .success(apiKey)
    }
}


