//
//  CreateSessionParameters.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

struct CreateSessionParameters: Codable {
    
    let recipeId: Int?
    let locale: String
    let customerId: Int
    let productId: Int
    let workflow: String?
    let environment: String?
    let baseUrl: String?
    let skipCdn: Bool?
    let configureEndpoint: String?
    let imageParameters: [ImageParameters]?
    let debug: Bool?
    
    init(
        recipeId: Int?,
        locale: String,
        customerId: Int,
        productId: Int,
        workflow: String?,
        environment: String?,
        baseUrl: String?,
        skipCdn: Bool?,
        configureEndpoint: String?,
        imageParameters: [ImageParameters]?,
        debug: Bool?
    ) {
        self.recipeId = recipeId
        self.locale = locale
        self.customerId = customerId
        self.productId = productId
        self.workflow = workflow
        self.environment = environment
        self.baseUrl = baseUrl
        self.skipCdn = skipCdn
        self.configureEndpoint = configureEndpoint
        self.imageParameters = imageParameters
        self.debug = debug
    }
    
}
