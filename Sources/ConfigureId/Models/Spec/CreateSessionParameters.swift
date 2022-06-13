//
//  CreateSessionParameters.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

public struct CreateSessionParameters: Codable {
    
    public let recipeId: Int?
    public let locale: String
    public let customerId: Int
    public let productId: Int
    public let workflow: String?
    public let environment: String?
    public let baseUrl: String?
    public let skipCdn: Bool?
    public let configureEndpoint: String?
    public let imageParameters: [ImageParameters]?
    public let debug: Bool?
    public let quantity: Int?
    
    public init(
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
        debug: Bool?,
        quantity: Int?
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
        self.quantity = quantity
    }
    
}
