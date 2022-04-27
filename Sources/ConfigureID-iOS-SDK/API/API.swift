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

extension ConfigureID {
    static func ensureApiKey() -> Result<String, Error> {
        // TODO: Return error on no api key
        guard let apiKey = ConfigureID.apiKey else {
            fatalError("TODO: return an error")
        }
        
        return .success(apiKey)
    }
}


