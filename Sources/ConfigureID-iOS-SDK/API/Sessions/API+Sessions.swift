//
//  File.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    struct Sessions {
        
        // TODO: Document
        public static func fetchSession(sessionId: String, onSuccess: @escaping (Session) -> (), onError: @escaping (ConfigureIDError) -> ()) {
        
            do {
                let request = try Request.Sessions.session(
                    sessionId: sessionId,
                    // TODO: Check Api key
                    apiKey: try ensureApiKey()
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                handleError(error: error, onError: onError)
            }
        }
        
        // TODO: Document
        public static func createSession(
            parameters: CreateSessionParameters,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                let request = try Request.Sessions.createSession(
                    // TODO: Check Api key
                    apiKey: try ensureApiKey(),
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
                handleError(error: error, onError: onError)
            }
        }
        
        public static func resetSession(
            sessionId: String,
            recipeId: String? = nil,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                let request = try Request.Sessions.resetSession(
                    // TODO: Check Api key
                    apiKey: try ensureApiKey(),
                    sessionId: sessionId,
                    recipeId: recipeId
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            }
            catch {
                handleError(error: error, onError: onError)
            }
        }
    }
}
