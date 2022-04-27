//
//  File.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

// TODO: Document
public struct CreateRecipeParameters: Codable {
    let sessionId: String
    let quantity: Int?
    let purpose: String?
    let addToCatalog: Bool?
    let catalogs: [String]?
    let customerData: CustomerData?
//    TODO: add this
//    let imageParameters: String?
}

struct CustomerData: Codable {
    let recipeName: String
    let buttonLabel: String
    let showPriceOnButton: Bool
    let saveOnSelected: Bool
    let author: String
}
