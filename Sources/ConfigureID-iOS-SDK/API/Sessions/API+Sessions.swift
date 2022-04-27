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
        public static func fetchSession(sessionId: String, onSuccess: @escaping (Session) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            let request = Request.Sessions.session(
                sessionId: sessionId,
                // TODO: Check Api key
                apiKey: try! apiKey.get()
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
        
        public static func resetSession(
            sessionId: String,
            recipeId: String? = nil,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (Error) -> ()
        ) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            do {
                let request = try Request.Sessions.resetSession(
                    // TODO: Check Api key
                    apiKey: try! apiKey.get(),
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
            } catch {
                // TODO: move this out
                fatalError("Error occurred get: \(error)")
            }
        }
    }
}
