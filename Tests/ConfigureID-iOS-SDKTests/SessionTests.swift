//
//  SessionTests.swift
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
                    XCTFail(error: $0)
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
                sessionId: "375e957-9e9e-4618-9090-3fc9918e894b",
                onSuccess: {
                    print($0)
                    fetchSession.fulfill()
                },
                onError: {
                    XCTFail(error: $0)
                    fetchSession.fulfill()
                }
            )
        
        waitForExpectations(timeout: 10)
    }
    
    func testResetSession() {
        let resetSession = expectation(description: "should reset session")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Sessions
            .resetSession(
                sessionId: "375e957-9e9e-4618-9090-3fc9918e894b",
                onSuccess: {
                    print($0)
                    resetSession.fulfill()
                },
                onError: {
                    XCTFail(error: $0)
                    resetSession.fulfill()
                }
            )
        
        waitForExpectations(timeout: 10)
    }
}

func XCTFail(error: Error, file: StaticString = #filePath, line: UInt = #line) {
    XCTFail(error.localizedDescription, file: file, line: line)
}
