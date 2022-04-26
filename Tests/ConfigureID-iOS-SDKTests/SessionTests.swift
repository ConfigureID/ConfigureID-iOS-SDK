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
        config = try TestConfig.loadFrom(fileName: "prod-config.json")
        ConfigureID.environment = config.environment
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
    func testCreateSession() {
        let products = expectation(description: "should create session")
        
        waitFor(seconds: 2)
        
        let parameters = CreateSessionParameters(
            recipeId: nil,
            locale: "en_US",
            customerId: config.customerId,
            productId: config.productId,
            workflow: config.workflow,
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
    
    func testFetchSession() {
        let fetchSession = expectation(description: "should fetch session")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Sessions
            .fetchSession(
//                sessionId: "8a35ebd2-d873-4527-bbd7-55ded62288f9",
//                sessionId: "560dda81-f623-46c6-ab75-98c2b3dcdccd",
//                sessionId: "ef3e6fe-8a5f-4722-b8de-ad93831a3f0c",
                sessionId: "9ef3e6fe-8a5f-4722-b8de-ad93831a3f0c",
                onSuccess: {
                    print($0)
                    fetchSession.fulfill()
                },
                onError: {
                    print($0)
                    fetchSession.fulfill()
                }
            )
        
        waitForExpectations(timeout: 10)
    }
}
