//
//  RecipeValue.swift
//  
//
//  Created by Francisco D. on 13/06/2022.
//

import Foundation

public enum RecipeValueType: Codable {
    case number(Int)
    case object([String:String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .number(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .object(container.decode([String: String].self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(
                    RecipeValueType.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
}


public struct RecipeValue: Codable {
    
    public let configurableAttributeId: Int
    public let selectedAttribute: RecipeValueType
    
    init(configurableAttributeId: Int, selectedAttribute: RecipeValueType) {
        self.configurableAttributeId = configurableAttributeId
        self.selectedAttribute = selectedAttribute
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let decoded = try container.decode([Int].self)
            guard let first = decoded[safe: 0] else {
                throw ConfigureIdError.decodingError(entity: "RecipeValue", originalError: "Couldn't find decoded[0] in [Int: Int]")
            }
            
            guard let second = decoded[safe: 1] else {
                throw ConfigureIdError.decodingError(entity: "RecipeValue", originalError: "Couldn't find decoded[1] in [Int: Int]")
            }
            
            self = RecipeValue(configurableAttributeId: first, selectedAttribute: .number(second))
        } catch DecodingError.typeMismatch {
            do {
                let decoded = try container.decode([RecipeValueType].self)
                
                guard let first = decoded[safe: 0] else {
                    throw ConfigureIdError.decodingError(entity: "RecipeValue", originalError: "Couldn't find decoded[0] in [Int: [String: String]]")
                }
                
                guard let second = decoded[safe: 1] else {
                    throw ConfigureIdError.decodingError(entity: "RecipeValue", originalError: "Couldn't find decoded[1] in [Int: [String: String]]")
                }
                
                switch first {
                case .number(let value):
                    self = RecipeValue(configurableAttributeId: value, selectedAttribute: second)
                case .object(_):
                    throw ConfigureIdError.decodingError(entity: "RecipeValue", originalError: "Couldn't find first value in [Int: [String: String]]")
                }
                
                
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(
                    RecipeValue.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
}
