//
//  ProductJson.swift
//  
//
//  Created by Francisco D. on 10/07/2022.
//

import Foundation

// TODO: Can't do it yet. Need clarification in documentation.
public struct ProductJson: Codable {
    
    /// The globally unique id of the product.
    public let id: Int
    
    public let attributes: [ProductJsonAttribute]
    
}

// TODO: Can't do it yet. Need clarification in documentation.
public struct ProductJsonAttribute: Codable {
    
    /// The globally unique id.
    public let id: Int
    
    public let name: String
    
    public let selectorType: String

    public let alias: String

    public let isVisible: Bool

    public let values: [AttributeValue]
    
    public let subAttributes: [ProductJsonAttribute]?
}
