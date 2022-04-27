//
//  File.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

public struct CreateSessionParameters: Codable {
    let recipeId: Int?
    let locale: String
    let customerId: Int
    let productId: Int
    let workflow: String?
    let environment: String?
    let productBaseUrl: String?
    let configureEndpoint: String?
    let imageParameters: [ImageParameters]?
    let debug: Bool?
    
    init(recipeId: Int?, locale: String, customerId: Int, productId: Int, workflow: String?, environment: String?, productBaseUrl: String?, configureEndpoint: String?, imageParameters: [ImageParameters]?, debug: Bool?) {
        self.recipeId = recipeId
        self.locale = locale
        self.customerId = customerId
        self.productId = productId
        self.workflow = workflow
        self.environment = environment
        self.productBaseUrl = productBaseUrl
        self.configureEndpoint = configureEndpoint
        self.imageParameters = imageParameters
        self.debug = debug
    }
}
