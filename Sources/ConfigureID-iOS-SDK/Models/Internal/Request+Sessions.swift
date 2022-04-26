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
        static func session(sessionId: String, apiKey: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/sessions/\(sessionId)"

            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        // TODO: add parameters to request
        static func createSession(apiKey: String, parameters: CreateSessionParameters) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/sessions"

            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
            
            let parametersData = try Environment.encoder.encode(parameters)
            
            return Request(method: .POST, urlComponents: components, httpBody: parametersData)
        }
    }
}
