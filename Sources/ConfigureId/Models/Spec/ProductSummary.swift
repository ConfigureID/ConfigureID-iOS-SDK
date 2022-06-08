//
//  ProductSummary.swift
//  
//
//  Created by Francisco D. on 25/04/2022.
//

import Foundation

public struct ProductSummary: Codable {

    /// The globally unique id of the product.
    let id: Int
        
    /// The name of the product.
//    TODO: This is object in API.
//    let name: String
    
    /// External id of the product.
    let vendorId: String
    
    // TODO: According documentation, this shouldn't be optional but it failed with one case.
    /// The identifier for the locale used by default. This is the locale that will be used when no locale is sent via query parameters.
//    let defaultLocale: String
    
    // TODO: According documentation, this shouldn't be optional but it failed with one case.
    /// The list of all available locales for the product.
//    let locales: [String]
    
    /// A list of Product Facets. Each product facet includes the values as a list.
    let facets: [ProductFacet]
    
}
