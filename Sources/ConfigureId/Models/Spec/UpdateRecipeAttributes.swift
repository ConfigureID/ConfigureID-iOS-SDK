//
//  UpdateRecipeAttributes.swift
//  
//
//  Created by Francisco D. on 16/05/2022.
//

import Foundation

public enum ConfigurableAttributeValue: Codable {
    case id(Int)
    case name(String)
    // TODO: Can't do it yet. Need clarification in documentation.
//    case Text (object)
//    case UGC clipart (object)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .id(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .name(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(
                    ConfigurableAttributeValue.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .id(let int):
            try container.encode(int)
        case .name(let string):
            try container.encode(string)
        }
    }
}
public enum ConfigurableAttributeToUpdate: Codable {
    case id(Int)
    case alias(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .id(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .alias(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(
                    ConfigurableAttributeToUpdate.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .id(let int):
            try container.encode(int)
        case .alias(let string):
            try container.encode(string)
        }
    }
}

public struct UpdateRecipeAttributes: Codable {
    
    /// Patch operation
    let op: String
    
    /// The configurable attribute to update.
    let configurableAttribute: ConfigurableAttributeToUpdate
    
    /// The attribute value to select/update.
    let attributeValue: ConfigurableAttributeValue
    
    /// Parameters for update recipe endpoint.
    /// - Parameters:
    ///   - op: Patch operation
    ///   - configurableAttribute: The configurable attribute to update.
    ///   - attributeValue: The attribute value to select/update.
    public init(op: String, configurableAttribute: ConfigurableAttributeToUpdate, attributeValue: ConfigurableAttributeValue) {
        self.op = op
        self.configurableAttribute = configurableAttribute
        self.attributeValue = attributeValue
    }
}
