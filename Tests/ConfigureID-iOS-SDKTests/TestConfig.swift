//
//  File.swift
//  
//
//  Created by Francisco D. on 19/04/2022.
//

import Foundation

extension String: Error {}

struct TestConfig: Codable {
    
    let apiKey: String
    let customerId: String
    let productId: String
    let vendorId: String
    
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
    
}
