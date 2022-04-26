//
//  ProductSummary.swift
//  
//
//  Created by Francisco D. on 25/04/2022.
//

import Foundation

public struct ProductSummary: Codable {
    let id: Int
    let name: String
    let vendorId: String
    let facets: [Facet]
    let defaultLocale: String
    let locales: [String]
}
