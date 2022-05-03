//
//  Request+Sessions.swift
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
            
            let parametersData: Data
            
            do {
                parametersData = try Environment.encoder.encode(parameters)
            } catch {
                throw ConfigureIDError.encodingError(entity: "CreateSession")
            }
            
            return Request(method: .POST, urlComponents: components, httpBody: parametersData)
        }
        
        static func resetSession(apiKey: String, sessionId: String, recipeId: String?) throws -> Request {
            do {
                var components = URLComponents()
                // TODO: allow to modify this
                components.scheme = "https"
                // TODO: allow to modify this
                components.host = ConfigureID.environment.host
                components.path = "/headless/sessions/\(sessionId)"
                
                components.queryItems = [
                    URLQueryItem(name: "apiKey", value: apiKey)
                ]
                
                let body: Data?
                
                if let recipeId = recipeId {
                    do {
                        body = try JSONSerialization.data(withJSONObject: ["recipeId": recipeId])
                    } catch {
                        throw ConfigureIDError.encodingError(entity: "resetSession")
                    }
                } else {
                    body = nil
                }
                
                return Request(method: .PUT, urlComponents: components, httpBody: body)
            }
        }
    }
}
