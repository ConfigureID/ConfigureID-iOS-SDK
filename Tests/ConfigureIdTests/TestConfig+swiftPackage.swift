//
//  TestConfig.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation
import ConfigureId

extension TestConfig {
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
    
    static func current() throws -> TestConfig {
        return try prod3dProduct()
    }

    static func prod2dProduct() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "prod-2d-product.json")
    }

    static func prod3dProduct() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "prod-3d-product.json")
    }

    static func staging() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "staging-config.json")
    }
}
