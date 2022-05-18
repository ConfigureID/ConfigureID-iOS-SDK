//
//  Request+Recipe.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation

extension Request {
    
    struct Recipes {
        
        static func fetchRecipe(
            recipeId: String,
            locale: String,
            includeLocalizedConfiguration: Bool,
            includeExtendedAttributes: Bool
        ) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/recipes/\(recipeId)"
            
            components.queryItems = [
                URLQueryItem(name: "locale", value: locale),
                URLQueryItem(name: "includeLocalizedConfiguration", value: includeLocalizedConfiguration.asQueryItem),
                URLQueryItem(name: "includeExtendedAttributes", value: includeExtendedAttributes.asQueryItem),
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func createRecipe(parameters: CreateRecipeParameters) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.host.stringValue
            components.path = "/headless/recipes"
            
            let parametersData = try Host.encoder.encode(parameters)
            
            return Request(
                method: .POST,
                urlComponents: components,
                httpBody: parametersData
            )
        }
        
    }
}
