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
        static func session(sessionId: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/sessions/\(sessionId)"
            
            return Request(method: .GET, urlComponents: components)
        }
        
        // TODO: add parameters to request
        static func createSession(parameters: CreateSessionParameters) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/sessions"
            
            let parametersData: Data
            
            do {
                parametersData = try Environment.encoder.encode(parameters)
            } catch {
                throw ConfigureIDError.encodingError(entity: "CreateSession")
            }
            
            return Request(method: .POST, urlComponents: components, httpBody: parametersData)
        }
        
        static func resetSession(sessionId: String, recipeId: String?) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/sessions/\(sessionId)"
            
            let body: Data?
            
            // TODO: Extract this to an extension
            if let recipeId = recipeId {
                do {
                    body = try ["recipeId": recipeId].toJSON()
                } catch {
                    throw ConfigureIDError.encodingError(entity: "resetSession")
                }
            } else {
                body = nil
            }
            
            return Request(method: .PUT, urlComponents: components, httpBody: body)
        }
//        
//        static func updateRecipe(sessionId: String, includeSummary: Bool) throws -> Request {
//            var components = URLComponents()
//            // TODO: allow to modify this
//            components.scheme = "https"
//            // TODO: allow to modify this
//            components.host = ConfigureID.environment.host
//            components.path = "/headless/sessions/\(sessionId)/recipe"
//            
//            let parametersData: Data
//            
//            do {
//                parametersData = try Environment.encoder.encode(parameters)
//            } catch {
//                throw ConfigureIDError.encodingError(entity: "CreateSession")
//            }
//            
//            return Request(method: .POST, urlComponents: components, httpBody: parametersData)
//        }
    }
}
