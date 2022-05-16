//
//  File.swift
//  
//
//  Created by Francisco D. on 16/05/2022.
//

import Foundation

public enum VariadicType: Codable {
    case int(Int)
    case string(String)
    //    TODO: object
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .int(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(
                    VariadicType.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}

public struct UpdateRecipeAttributes: Codable {
    // TODO: Pedro would send the real values, this probably should be an enum.

    /// Patch operation
    let op: String
    
    /// The configurable attribute to update.
    let configurableAttribute: VariadicType
    
    /// The attribute value to select/update.
    let attributeValue: VariadicType
}
