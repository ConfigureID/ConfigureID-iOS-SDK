//
//  CreateRecipeParameters.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

// TODO: Document
struct CreateRecipeParameters: Codable {
    
    /// Id of a sesstion to create a recipe.
    let sessionId: String
    
    /// Amount of products created with this recipe.
    /// Default: 1
    let quantity: Int?
    
    /// The purpose of creating recipe.
    let purpose: String?
    
    /// True if should be included in recipe-search index.
    let addToCatalog: Bool?
    
    /// List of catalogs for recipe in the recipe-search index.
    let catalogs: [String]?
    
    // TODO
    /// Custom paylod to be saved with recipe document.
//    let customerData: CustomerData?
//    TODO: add this
//    let imageParameters: String?
}
