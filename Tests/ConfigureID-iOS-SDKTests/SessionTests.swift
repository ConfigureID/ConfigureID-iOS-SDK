//
//  File.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation
import XCTest
@testable import ConfigureID_iOS_SDK

final class SessionTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        config = try TestConfig.loadFrom(fileName: "staging-config.json")
        ConfigureID.environment = config.environment
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
    func testCreateSession() {
        let products = expectation(description: "should create session")
        
        waitFor(seconds: 2)
        
        let parameters = CreateSessionParameters(
            recipeId: nil,
            locale: "en",
            customerId: config.customerId,
            productId: config.productId,
            workflow: nil,
            environment: nil,
            productBaseUrl: nil,
            configureEndpoint: nil,
            imageParameters: nil,
            debug: nil
        )
        
        ConfigureID
            .Sessions
            .createSession(
                parameters: parameters,
                onSuccess: {
                    print($0)
                    products.fulfill()
                },
                onError: {
                    print($0)
                    products.fulfill()
                }
            )

        waitForExpectations(timeout: 10)
    }
}
