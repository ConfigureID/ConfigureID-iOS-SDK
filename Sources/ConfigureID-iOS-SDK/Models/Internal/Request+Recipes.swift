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
        static func recipe(recipeId: String, apiKey: String, workflow: String) -> Request {
            var components = URLComponents()
            // TODO: allow to modify this
            components.scheme = "https"
            // TODO: allow to modify this
            components.host = Request.host
            components.path = "/recipes/\(recipeId)"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return Request(method: .GET, urlComponents: components)
        }
        
    }
}
