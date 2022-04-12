//
//  AtributeValue.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

struct AttributeValue: Codable {
    /// A globally unique id for the attribute value.
    /// - Note: Example: 7904
    let id: Int
    
    /// It indicates if the attribute value is active.
    /// - Note: Example: true
    let active: Bool
    
//  TODO
//    let clipArtConfig: ClipArtConfig
    
    /// A CSS-style hex code, if the attribute value is associated with a color.
    /// - Note: Example: #811cb4
    let color: String
    
    /// A localized description of the attribute value.
    /// - Note: Example: A random description
    let description: String
    
    /// The localized name for the attribute value
    /// - Note: Example: PM
    let name: String
    
    /// A number that is used to sort attribute values in the set of selectable values for a configurable attribute. Higher numbers are sorted first.
    /// - Note: Example: 37
    let priority: Int
    
//    TODO
//    let textConfig: TextConfig
    
    
    /// External id of the attribute value.
    /// - Note: Example: MMS01
    let vendorId: String
    
    // TODO
//    let upcharge: Upcharge
}
