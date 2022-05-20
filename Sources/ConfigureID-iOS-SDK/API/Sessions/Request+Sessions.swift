//
//  Request+Sessions.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

extension Request {
    
    struct Sessions {
        
        static func session(sessionId: String) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/sessions/\(sessionId)"
            
            return Request(method: .GET, urlComponents: components)
        }
        
        // TODO: add parameters to request
        static func createSession(parameters: CreateSessionParameters) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/sessions"
            
            let parametersData: Data
            
            do {
                parametersData = try Host.encoder.encode(parameters)
            } catch {
                throw ConfigureIDError.encodingError(entity: "CreateSession", originalError: error)
            }
            
            return Request(method: .POST, urlComponents: components, httpBody: parametersData)
        }
        
        static func resetSession(sessionId: String, recipeId: String?) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/sessions/\(sessionId)"
            
            let body: Data?
            
            if let recipeId = recipeId {
                do {
                    body = try ["recipeId": recipeId].toJSON()
                } catch {
                    throw ConfigureIDError.encodingError(entity: "resetSession", originalError: error)
                }
            } else {
                body = nil
            }
            
            return Request(method: .PUT, urlComponents: components, httpBody: body)
        }
        
        static func updateSession(sessionId: String, locale: String?, quantity: Int?) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/sessions/\(sessionId)/recipe"
                        
            var parametersData: Data?
            
            var parameters: [String: Any] = [:]
            
            if let locale = locale {
                parameters["locale"] = locale
            }
            
            if let quantity = quantity {
                parameters["quantity"] = quantity
            }
            
            if !parameters.isEmpty {
                do {
                    parametersData = try parameters.toJSON()
                } catch {
                    throw ConfigureIDError.encodingError(entity: "updateRecipe", originalError: error)
                }
            }
            
            return Request(method: .PUT, urlComponents: components, httpBody: parametersData)
        }
        
        static func updateRecipe(sessionId: String, includeSummary: Bool, updates: [UpdateRecipeAttributes]) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/sessions/\(sessionId)/recipe"
                        
            let parametersData: Data
            
            do {
                parametersData = try Host.encoder.encode(updates)
            } catch {
                throw ConfigureIDError.encodingError(entity: "updateRecipe", originalError: error)
            }
            
            return Request(method: .PATCH, urlComponents: components, httpBody: parametersData)
        }
    }
}
