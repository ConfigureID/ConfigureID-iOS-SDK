//
//  TestConfig.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation
import ConfigureId

extension String: Error {}

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
    
    static func loadFrom(fileName: String) throws -> TestConfig {
        let file = fileName.replacingOccurrences(of: ".json", with: "")
        guard let url = Bundle.module.url(
            forResource: file,
            withExtension: "json") else {
            throw "Config file \(fileName) for testing doesn't exist"
        }
        let jsonData = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(TestConfig.self, from: jsonData)
    }
    
    static func prod() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "prod-config.json")
    }
    
    static func staging() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "staging-config.json")
    }
}
