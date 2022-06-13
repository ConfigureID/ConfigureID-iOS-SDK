//
//  Product.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

public struct Product: Codable {
    
    /// The globally unique id of the product.
    public let id: Int
    
    /// The name of the product.
    public let name: String
    
    /// A localized description of the product.
    public let description: String
    
    /// External id of the product.
    public let vendorId: String
    
    /// The identifier for the locale used by default.
    public let defaultLocale: String
    
    /// The identifier for the current locale used to show the product configuration
    public let locale: String
    
    /// The list of all available locales for the product.
    public let locales: [String]
    
    /// A list of all the currencies.
    public let currencies: [String]
    
    /// A url template to access a product recipe.
    public let recipeUrlTemplate: String
    
    /// The list of the active configurable attributes.
    public let attributes: [ConfigurableAttribute]
    
    /// Key-value pairs of currency codes and the corresponding base price.
    public let prices: [String: Double]
    
    /// A list of Product Facets. Each product facet includes the values as a list.
    public let facets: [ProductFacet]
}
