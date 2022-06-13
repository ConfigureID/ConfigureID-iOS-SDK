//
//  CreateRecipeParameters.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

public struct CreateRecipeParameters: Codable {
    
    /// Id of a sesstion to create a recipe.
    public let sessionId: String
    
    /// Amount of products created with this recipe.
    /// Default: 1
    public let quantity: Int?
    
    /// The purpose of creating recipe.
    public let purpose: String?
    
    /// True if should be included in recipe-search index.
    public let addToCatalog: Bool?
    
    /// List of catalogs for recipe in the recipe-search index.
    public let catalogs: [String]?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// Custom paylod to be saved with recipe document.
//    let customerData: CustomerData?
    
    public let imageParameters: [ImageParametersRecipe]?
}
