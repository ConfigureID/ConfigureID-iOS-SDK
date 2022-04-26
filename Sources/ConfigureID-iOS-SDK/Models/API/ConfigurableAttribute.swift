//
//  ConfigurableAttribute.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

struct ConfigurableAttribute: Codable {
    
    /// The globally unique id of the attribute.
    /// - Note: Example: 23460
    let id: Int
    
    /// A non-localized unique name for the configurable attribute.
    /// - Note: Example: product_size_jde
    let alias: String
    
    /// A localized description of the attribute.
    /// - Note: Example: Select size
    let description: String
    
    /// It means if an attribute is indexable.
    /// - Note: Example: true
    let indexable: Bool
    
    /// The localized name of the attribute.
    /// - Note: Example: Size
    let name: String
    
    /// A localized string for a tooltip of the attribute.
    let tooltip: String
    
    /// External id of the attribute.
    /// - Note: Example: OWT43
    let vendorId: String
    
    // TODO: Change this to an enum
    /// The type of the configurable attribute. One of valueList, text, clipart or ugcClipart.
    /// - Note: Example: valueList
    let type: String
    
    /// The id of the configurable attribute parent.
    /// - Note: Example: ca34635
    let parentId: Int?
    
//    TODO: What is swatchTemplate, what fields does it have?
    /// The swatch template.
//    let swatchTemplate: SwatchTemplate
    
    /// The list of associated facets.
    let facets: [Facet]
    
//    TODO: what type is this?
//    let subAttributes: SubAttributes
    
    /// The list of artributes values.
    let attributeValues: [AttributeValue]
}
