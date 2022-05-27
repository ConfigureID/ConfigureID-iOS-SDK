//
//  API.swift
//  
//
//  Created by Francisco D. on 13/04/2022.
//

import Foundation

public enum Host {
    case prod
    case staging
    case custom(String)
    
    var stringValue: String {
        switch self {
        case .prod:
            return "prod-ingress.fluidconfigure.com"
            
        case .staging:
            return "staging-ingress.fluidconfigure.com"
            
        case .custom(let customHost):
            return customHost
        }
    }
    
    static var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    static var decoder: JSONDecoder {
        return JSONDecoder()
    }
}

/// This API exposes the endpoints necessary for interacting with Configure.
public struct ConfigureId {
    
    static var apiKey: String?
    
    static var host: Host = .prod
    
    init(apiKey: String) {
        ConfigureId.setApiKey(apiKey: apiKey)
    }
    
    /// Sets the API key that will be used to validate the customer.
    public static func setApiKey(apiKey: String) {
        ConfigureId.apiKey = apiKey
    }
    
    /// Sets the API host (without https part).
    /// Example value: .custom("prod-ingress.fluidconfigure.com")
    public static func setHost(host: Host) {
        self.host = host
    }
    
}

func handleError(
    error: Error,
    onError: (ConfigureIdError) -> ()
) {
    if let error = error as? ConfigureIdError {
        onError(error)
        return
    }
    
    onError(.unknownError(error))
}
