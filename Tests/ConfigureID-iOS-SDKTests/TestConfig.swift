//
//  TestConfig.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation
@testable import ConfigureID_iOS_SDK

extension String: Error {}

extension Environment: Codable {}

struct TestConfig: Codable {
    
    let apiKey: String
    let customerId: Int
    let productId: Int
    let vendorId: String
    let environment: Environment
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
