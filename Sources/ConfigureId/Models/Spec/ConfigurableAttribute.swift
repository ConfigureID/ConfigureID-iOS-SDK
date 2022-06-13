//
//  ConfigurableAttribute.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

public struct ConfigurableAttribute: Codable {
    
    /// The globally unique id of the attribute.
    /// - Note: Example: 23460
    public let id: Int
    
    /// A non-localized unique name for the configurable attribute.
    /// - Note: Example: product_size_jde
    public let alias: String
    
    /// A localized description of the attribute.
    /// - Note: Example: Select size
    public let description: String
    
    /// It means if an attribute is indexable.
    /// - Note: Example: true
    public let indexable: Bool
    
    /// The localized name of the attribute.
    /// - Note: Example: Size
    public let name: String
    
    /// A localized string for a tooltip of the attribute.
    public let tooltip: String
    
    /// External id of the attribute.
    /// - Note: Example: OWT43
    public let vendorId: String
    
    /// The type of the configurable attribute. One of valueList, text, clipart or ugcClipart.
    /// - Note: Example: valueList
    public let type: String
    
    /// The id of the configurable attribute parent.
    /// - Note: Example: ca34635
    public let parentId: Int?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// The swatch template.
//    let swatchTemplate: SwatchTemplate
    
    // TODO: I can do this
    /// The list of associated facets.
//    let facets: [Facet]
    
    // TODO: Can't do it yet. Need clarification in documentation.
//    let subAttributes: SubAttributes
    
    /// The list of artributes values.
    public let attributeValues: [AttributeValue]
}
