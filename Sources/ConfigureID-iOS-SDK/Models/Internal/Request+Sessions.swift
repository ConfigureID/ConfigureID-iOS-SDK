//
//  File.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

extension Request {
    
    struct Sessions {
        
        // TODO: is workflow needed?
        static func session(sessionId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/sessions/\(sessionId)"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
    }
}
