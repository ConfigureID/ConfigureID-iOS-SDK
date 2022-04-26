//
//  ConfigureSessionDTo.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

// TODO: Document ConfigureSessionDTo
public struct Session: Codable {
    let sessionId: String
    // TODO: What is this?
//    let productJson: ProductJson
    let price: Int
    let quantity: Int
    
    // TODO: Implement
//    let recipe: Recipe
    
    // TODO: Implement
//    let imageUrlParameters: ImageUrlParameters
    let isWebGl: Bool
}
