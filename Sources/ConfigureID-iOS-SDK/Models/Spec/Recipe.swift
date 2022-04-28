//
//  File.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation

public struct Recipe: Codable {
    
    /// The id of the recipe.
    let id: Int?
    
    /// The id of the customer.
    let customerId: Int?
    
    /// The environment identifier.
    let environment: String?
    
    /// The workflow identifier.
    let workflow: String?
    
    // TODO: What is this?
//    let productQuantities: ProductQuantities?
    
    /// Purpose of adding to cart.
    let purpose: String?
        
    /// Names of catalogs in the recipe-search that this recipe is a part of.
    let catalogId: [String]?
    
    /// The identifier for locale used to show the configuration.
    let locale: String?
    
    /// Creation date.
    let creationDate: String?
    
    // TODO: Add this
//    let prices: Prices
    
    /// True if recipe is included indexed in recipe-search service.
    let isSearchable: Bool?
    
    // TODO: Add this
//    let custom: Custom
    
    // TODO: Add this
//    let images: Images
//    let product: Product?
    
    // TODO: Add this
//    let configuration: Configuration?
    
    // TODO: Add this
//    let configurableAttributes: ConfigurableAttributes?
    let version: Int?
    let uri: String?
    
    // TODO: Add this
//    let localizedConfiguration: LocalizedConfiguration?
    
    // TODO: Add this
//    let extendedAttributes: ExtendedAttributes?
}
