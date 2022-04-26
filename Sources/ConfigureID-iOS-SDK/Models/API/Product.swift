//
//  Product.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

// TODO: Check optionals
public struct Product: Codable {
    
    /// The globally unique id of the product.
    /// - Note: Example: 20960
    let id: Int
    
    /// The name of the product.
    /// - Note: Example: Spaceship
    let name: String
    
    /// A localized description of the product.
    /// - Note: Example: A craft to go to space
    let description: String
    
    /// External id of the product.
    /// - Note: Example: 91813
    let vendorId: String
    
    /// The identifier for the locale used by default.
    /// - Note: Example: en_US
    let defaultLocale: String
    
    /// The identifier for the current locale used to show the product configuration. If it is called without specificing locale, it will be the same as the value of defaultLocale.
    /// - Note: Example: en_US
    let locale: String
    
    /// The list of all available locales for the product.
    /// - Note: Example: [ "en_US"]
    let locales: [String]
    
    // TODO: Do the currency format follow any standard or should I treat them as simple strings?
    /// A list of all the currencies.
    /// - Note: Example: [ "AUD", "BRL", "CAD", "CHF", "CNY", "DKK" ]
    let currencies: [String]
    
    /// A url template to access a product recipe.
    let recipeUrlTemplate: String
    
    /// The list of the active configurable attributes.
    let attributes: [ConfigurableAttribute]
    
    /// A list of the prices with the corresponding currency.
    /// - Note: Example: [ "USD": 1.99, "GBP": 1.63, "CAD": 2.11 ]
    let prices: [String: Double]?
}
