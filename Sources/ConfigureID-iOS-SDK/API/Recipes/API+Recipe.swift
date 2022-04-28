//
//  File.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    struct Recipes {
        
        // TODO: Add locale, includeLocalizedConfiguration, includeExtendedAttributes, etc...
        public static func fetchRecipe(recipeId: String, workflow: String, onSuccess: @escaping (Recipe) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
//            let request = Request.Sessions.session(
//                sessionId: recipeId,
//                // TODO: Check Api key
//                apiKey: try! apiKey.get(),
//                workflow: workflow
//            )
//
//            NetworkService
//                .shared
//                .executeRequest(
//                    request: request,
//                    onSuccess: onSuccess,
//                    onError: onError
//                )
        }
        
        // TODO: remove parameters and add them to the function
        public static func createRecipe(parameters: CreateRecipeParameters, onSuccess: @escaping (Recipe) -> (), onError: @escaping (Error) -> ()) {
            let apiKey = ensureApiKey()
            // TODO: Check Api key
            
            do {
                let request = try Request.Recipes.createRecipe(
                    //                // TODO: Check Api key
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
                // TODO
                print("Error ocurred")
            }
        }
    }
}
