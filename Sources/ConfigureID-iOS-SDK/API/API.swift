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
    static var apiKey: String?
    
    // TODO: Should this be changeable?
    static var environment: Environment = .prod
    
    // TODO: is this ok?
    init(apiKey: String) {
        ConfigureID.setApiKey(apiKey: apiKey)
    }
    
    
    /// The API key will be used to validate the customer ID used in the url
    public static func setApiKey(apiKey: String) {
        ConfigureID.apiKey = apiKey
    }
    
}

func handleError(
    error: Error,
    onError: (ConfigureIDError) -> ()
) {
    if let error = error as? ConfigureIDError {
        onError(error)
        return
    }
    
    onError(.unknownError(error))
}
