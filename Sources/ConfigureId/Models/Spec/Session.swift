//
//  ConfigureSessionDTo.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
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
                    VariadicType.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
}

extension String: Error {}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
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
                    VariadicType.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type")
                )
            }
        }
    }
}

// TODO: Document ConfigureSessionDTo
public struct Session: Codable {
    
    /// Id of the session
    public let sessionId: String
    // TODO: What is this?
    
    /// Product configuration from configure-core
//    let productJson: ProductJson
    
    public let price: Float
    
    public let quantity: Int
    
    // TODO: Implement
    public let recipe: [RecipeValue]
    
    /// Whether product is WebGl
    public let isWebGl: Bool
    
//    TODO
    public let imageUrls: ImageUrls?
    
    // TODO
//    let changes
}

// TODO: Check this onBust what's the type of this.
public struct ImageUrls: Codable {
    
    public let onBust: String
}
