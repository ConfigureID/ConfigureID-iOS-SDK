//
//  ConfigureSessionDTo.swift
//  
//
//  Created by Francisco D. on 18/04/2022.
//

import Foundation

// TODO: Document ConfigureSessionDTo
public struct Session: Codable {
    
    /// Id of the session
    let sessionId: String
    // TODO: What is this?
    
    /// Product configuration from configure-core
//    let productJson: ProductJson
    let price: Int
    let quantity: Int
    
    // TODO: Implement
//    let recipe: Recipe
    
    /// Whether product is WebGl
    let isWebGl: Bool
    
//    TODO
//    let imageUrls
}
