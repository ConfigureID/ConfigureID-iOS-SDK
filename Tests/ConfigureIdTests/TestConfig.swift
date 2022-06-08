//
//  File.swift
//  
//
//  Created by Francisco D. on 06/06/2022.
//

import Foundation
import ConfigureId

extension Host: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedHost = try container.decode(String.self)
        if decodedHost == "prod" {
            self = .prod
            return
        }
        
        if decodedHost == "staging" {
            self = .staging
            return
        }
        
        self = .custom(decodedHost)
    }
}

struct TestConfig: Decodable {
    
    let apiKey: String
    let customerId: Int
    let productId: Int
    let vendorId: String
    let host: Host
    let workflow: String
    let sessionId: String
    let recipeId: String
}
