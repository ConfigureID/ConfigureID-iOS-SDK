//
//  Facet.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

public struct ProductFacet: Codable {
    
    /// The name for the product facet.
    public let name: String
    
    /// The list of Facet Values.
    public let values: [String]
    
}
