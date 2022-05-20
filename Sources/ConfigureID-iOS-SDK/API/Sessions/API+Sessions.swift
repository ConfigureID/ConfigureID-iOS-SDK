//
//  API+Sessions.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    /// Sessions endpoints
    struct Sessions {
        
        /// Retrieves the current state of the session.
        /// - Parameters:
        ///   - sessionId: Id of a session.
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
        public static func fetchSession(
            sessionId: String,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
        
            do {
                let request = try Request.Sessions.session(
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
        
        /// Creates a new session.
        /// - Parameters:
        ///   - locale: The locale identifier to select the language. Should be >= 2 characters.
        ///   - customerId: Id of a customer.
        ///   - productId: Id of the product.
        ///   - recipeId: Id of recipe.
        ///   - workflow: The workflow identifier.
        ///   - environment: The environment identifier.
        ///   - baseUrl: Base url for getting assets.
        ///   - skipCdn: Whether should skip cdn.  Default: false.
        ///   - configureEndpoint: Defines configure endpoint to be used when interacting with the API.
        ///   - imageParameters: Parameters used to generate image. If not present default parameters and view name will be used.
        ///   - debug: True if is debug mode.
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
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
        
        /// Resets a session.
        /// - Parameters:
        ///   - sessionId: Id of a session.
        ///   - recipeId: Id of recipe.
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
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
            } catch {
                handleError(error: error, onError: onError)
            }
        }
        
        /// Update session.
        /// - Parameters:
        ///   - sessionId: Id of a session.
        ///   - locale: The locale identifier to select the language. Should be >= 2 characters.
        ///   - quantity: Amount of products created with this recipe.  Must be >= 1. Default: 1
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
        public static func updateSession(
            sessionId: String,
            locale: String?,
            quantity: Int?,
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                let request = try Request.Sessions.updateSession(
                    sessionId: sessionId,
                    locale: locale,
                    quantity: quantity
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
        
        /// Updates a recipe.
        /// - Parameters:
        ///   - sessionId: Id of a session.
        ///   - includeSummary: Indicates if an array of changes is returned in the response. Useful for debugging/testing purposes.
        public static func updateRecipe(
            sessionId: String,
            includeSummary: Bool,
            updates: [UpdateRecipeAttributes],
            onSuccess: @escaping (Session) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                let request = try Request.Sessions.updateRecipe(
                    sessionId: sessionId,
                    includeSummary: includeSummary,
                    updates: updates
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
    }
}
