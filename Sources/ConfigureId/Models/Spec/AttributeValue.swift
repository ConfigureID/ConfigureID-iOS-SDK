//
//  AtributeValue.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

public struct AttributeValue: Codable {
    /// A globally unique id for the attribute value.
    /// - Note: Example: 7904
    public let id: Int
    
    /// It indicates if the attribute value is active.
    /// - Note: Example: true
    public let active: Bool
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// The additional data on how to render the clipart if the attribute value is used in a clipartRelation.
//    let clipArtConfig: ClipArtConfig
    
    /// A CSS-style hex code, if the attribute value is associated with a color.
    /// - Note: Example: #811cb4
    public let color: String?
    
    /// A localized description of the attribute value.
    /// - Note: Example: A random description
    public let description: String
    
    /// The localized name for the attribute value
    /// - Note: Example: PM
    public let name: String
    
    /// A number that is used to sort attribute values in the set of selectable values for a configurable attribute. Higher numbers are sorted first.
    /// - Note: Example: 37
    public let priority: Int
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// The additional data on how to render the text if the attribute value is used in a textRelation.
//    let textConfig: TextConfig
    
    /// External id of the attribute value.
    /// - Note: Example: MMS01
    public let vendorId: String?
    
    // TODO: Can't do it yet. Need clarification in documentation.
    /// Key-value pairs of currency codes and the cost added to the base price if this attribute value is selected.
//    let upcharge: Upcharge
}

public struct SubAttribute: Codable {

    public let id: Int
    
    public let name: String
    
    public let values: [AttributeValue]
    
}
