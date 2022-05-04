//
//  Request+Recipe.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation

extension Request {
    
    struct Recipes {
        
        // TODO: is workflow needed?
        static func fetchRecipe(recipeId: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/recipes/\(recipeId)"

            components.queryItems = [
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
        static func createRecipe(parameters: CreateRecipeParameters) throws -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = ConfigureID.environment.host
            components.path = "/headless/recipes"
            
            let parametersData = try Environment.encoder.encode(parameters)
            
            return Request(
                method: .POST,
                urlComponents: components,
                httpBody: parametersData
            )
        }
        
    }
}
