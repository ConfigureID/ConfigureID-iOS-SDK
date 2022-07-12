//
//  ConfigureSessionDTo.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

public struct Session: Codable {
    
    /// Id of the session
    public let sessionId: String
    
    /// Product configuration from configure-core
    public let productJson: ProductJson
    
    public let price: Float
    
    public let quantity: Int
    
    /// All the changes done to the session recipe.
    public let recipe: [RecipeValue]
    
    /// Whether product is WebGl
    public let isWebGl: Bool
    
    /// Urls to be used to get the image for particular view.
    public let imageUrls: [String: String]?
}
