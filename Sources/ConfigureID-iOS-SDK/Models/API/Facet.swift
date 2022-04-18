//
//  Facet.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

struct Facet: Codable {
    
    /// The globally unique id of the attribute.
    /// - Note: Example: 20901
    let id: Int
    
    /// The localized name for the facet
    /// - Note: Example: Core color
    let name: String
    
    
    /// The description for the facet.
    /// - Note: Example: Description of Core color
    let description: String
    
    
    /// The label for the facet.
    /// - Note: Example: Label of Core color
    let label: String
    
    
    /// The selector type.
    /// - Note: Example: dropdown
    let selectorType: String
      
    /// The list of FacetValues
    let facetValues: [FacetValue]
}
