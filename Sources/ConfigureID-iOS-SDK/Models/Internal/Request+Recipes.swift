//
//  File.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation

extension Request {
    
    struct Recipes {
        
        // TODO: is workflow needed?
        static func fetchRecipe(recipeId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/recipes/\(recipeId)"

            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func createRecipe(apiKey: String, parameters: CreateRecipeParameters) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/recipes"

            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
            
            return Request(method: .POST, urlComponents: components)
        }
        
    }
}
