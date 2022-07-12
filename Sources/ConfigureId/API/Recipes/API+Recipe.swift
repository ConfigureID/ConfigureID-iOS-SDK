//
//  API+Recipe.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureId {
    
    /// Recipes endpoints.
    struct Recipes {
        
        /// Retrieves an existing recipe.
        /// - Parameters:
        ///   - recipeId: Id of a recipe.
        ///   - locale: The locale identifier to select the language.  Example: locale=en_US.
        ///   - includeLocalizedConfiguration: Defines if localized_configuration should be included.
        ///   - includeExtendedAttributes: Defines if extended_attributes should be included.
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
        public static func fetchRecipe(
            recipeId: String,
            locale: String? = nil,
            includeLocalizedConfiguration: Bool? = nil,
            includeExtendedAttributes: Bool? = nil,
            onSuccess: @escaping (Recipe) -> (),
            onError: @escaping (ConfigureIdError) -> ()
        ) {
            do {
                let request = try Request.Recipes.fetchRecipe(
                    recipeId: recipeId,
                    locale: locale,
                    includeLocalizedConfiguration: includeLocalizedConfiguration,
                    includeExtendedAttributes: includeExtendedAttributes
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
        
        /// Creates a new recipe.
        /// - Parameters:
        ///   - sessionId: Id of a sesstion to create a recipe.
        ///   - quantity: Amount of products created with this recipe.  Must be >= 1. Default: 1
        ///   - purpose: The purpose of creating recipe.
        ///   - addToCatalog: True if should be included in recipe-search index.
        ///   - catalogs: List of catalogs for recipe in the recipe-search index.
        ///   - customerData: Custom paylod to be saved with recipe document.
        ///   - imageParameters: Parameters to be used for recipe images. Default: "{ viewName: defaultViewName, scale: 1, format: \"png\" }".
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
        public static func createRecipe(
            sessionId: String,
            quantity: Int? = nil,
            purpose: String? = nil,
            addToCatalog: Bool? = nil,
            catalogs: [String]? = nil, 
            imageParameters: [ImageParametersRecipe]? = nil,
            // TODO: Can't do it yet. Need clarification in documentation.
            // customerData
            onSuccess: @escaping (CreatedRecipe) -> (),
            onError: @escaping (ConfigureIdError) -> ()
        ) { 
            do {
                let request = try Request.Recipes.createRecipe(
                    parameters: CreateRecipeParameters(
                        sessionId: sessionId,
                        quantity: quantity,
                        purpose: purpose,
                        addToCatalog: addToCatalog,
                        catalogs: catalogs,
                        imageParameters: imageParameters
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
    }
}
