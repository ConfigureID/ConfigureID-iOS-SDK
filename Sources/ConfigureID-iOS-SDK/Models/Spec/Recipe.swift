//
//  File.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation

public struct Recipe: Codable {
    let id: Int
    let customerId: Int
    let environment: String
    let workflow: String
    
    // TODO: What is this?
//    let productQuantities: ProductQuantities
    let purpose: String
    let catalogId: [String]
    let locale: String
    let creationDate: String
    
    // TODO: Add this
//    let prices: Prices
    
    let isSearchable: Bool
    
    // TODO: Add this
//    let custom: Custom
    
    // TODO: Add this
//    let images: Images
    let product: Product
    
    // TODO: Add this
//    let configuration: Configuration
    
    // TODO: Add this
//    let configurableAttributes: ConfigurableAttributes
    let version: Int
    let uri: String
    
    // TODO: Add this
//    let localizedConfiguration: LocalizedConfiguration
    
    // TODO: Add this
//    let extendedAttributes: ExtendedAttributes
}
