//
//  ProductSummary.swift
//  
//
//  Created by Francisco D. on 25/04/2022.
//

import Foundation

public struct ProductReport: Codable {

    /// The globally unique id of the product.
    let id: Int
        
    // TODO: Can't do it yet. Need clarification in documentation.
    /// A dictionary with the name of the product in the different locales.
//    let name: String
    
    /// External id of the product.
    let vendorId: String
    
    /// The identifier for the locale used by default. This is the locale that will be used when no locale is sent via query parameters.
    let defaultLocale: String
    
    /// The list of all available locales for the product.
    let locales: [String]
    
    /// A list of Product Facets. Each product facet includes the values as a list.
    let facets: [ProductFacet]
    
}
