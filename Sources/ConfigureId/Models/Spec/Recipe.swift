//
//  Recipe.swift
//  
//
//  Created by Francisco D. on 09/05/2022.
//

import Foundation

public struct RecipeProduct: Codable {
    let id: Int
    let name: String
    let vendor_id: String?
}

public struct Recipe: Codable {
    
    /// The id of the recipe.
    let id: Int
    
    /// The id of the customer.
    let customerId: Int?
    
    /// The environment identifier.
    let environment: String?
    
    /// The workflow identifier.
    let workflow: String?
    
    // TODO: Can't do it yet. Need clarification in documentation.
//    let productQuantities: ProductQuantities?
    
    /// Purpose of adding to cart.
    let purpose: String?
        
    /// Names of catalogs in the recipe-search that this recipe is a part of.
    let catalogId: [String]?
    
    /// The locale identifier to select the language.
    let locale: String?
    
    /// Creation date.
    let creationDate: String?
    
    /// A list of the prices with the corresponding currency.
    public let prices: [String: Double]
    
    /// True if recipe is included indexed in recipe-search service.
    let isSearchable: Bool?
    
    // TODO: Can't do it yet. Need clarification in documentation.
//    Custom data added to the payload when saving recipe. Does not have particular schema.
//    let custom: Custom
    
    // TODO: Can't do it yet. Need clarification in documentation.
//    let images: Images
    let product: RecipeProduct?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// Legacy representation of recipe configuration.
//    let configuration: Configuration?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// Object with keys being the attributeId (preceding with its parent attributeId) and the value for every key being the attributeValueId selected.
//    let configurableAttributes: ConfigurableAttributes?
    
    /// Configuration version used when creating the recipe.
    let version: Int?
    
    /// Url to access recipe.
    let uri: String?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// Recipe configuration with localized AV names. Depend on locale query parameter.
//    let localizedConfiguration: LocalizedConfiguration?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// Additional info on Configurable Attributes, selected Attribute Values, facets, etc.
//    let extendedAttributes: ExtendedAttributes?
}
