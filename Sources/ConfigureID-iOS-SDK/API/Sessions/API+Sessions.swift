//
//  API+Sessions.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    struct Sessions {
        
        // TODO: Document
        public static func fetchSession(
            sessionId: String,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
        
            do {
                let request = Request.Sessions.session(
                    sessionId: sessionId
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
            locale: String,
            customerId: Int,
            productId: Int,
            recipeId: Int? = nil,
            workflow: String? = nil,
            environment: String? = nil,
            baseUrl: String? = nil,
            skipCdn: Bool? = nil,
            configureEndpoint: String? = nil,
            imageParameters: [ImageParameters]? = nil,
            debug: Bool? = nil,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                let request = try Request.Sessions.createSession(
                    parameters: CreateSessionParameters(
                        recipeId: recipeId,
                        locale: locale,
                        customerId: customerId,
                        productId: productId,
                        workflow: workflow,
                        environment: environment,
                        baseUrl: baseUrl,
                        skipCdn: skipCdn,
                        configureEndpoint: configureEndpoint,
                        imageParameters: imageParameters,
                        debug: debug
                    )
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
//        
//        public static func updateRecipe() {
//            do {
//                let request = try Request.Sessions.updateRecipe(
//                    sessionId: sessionId,
//                    recipeId: recipeId
//                )
//                
//                NetworkService
//                    .shared
//                    .executeRequest(
//                        request: request,
//                        onSuccess: onSuccess,
//                        onError: onError
//                    )
//            }
//            catch {
//                handleError(error: error, onError: onError)
//            }
//        }
    }
}
