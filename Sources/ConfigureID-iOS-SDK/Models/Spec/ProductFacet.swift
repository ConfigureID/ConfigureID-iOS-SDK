//
//  Facet.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

struct ProductFacet: Codable {
    
    /// The name for the product facet.
    let name: String
    
    /// The list of facet values.
    let values: [String]
    
}
