//
//  SessionTests.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation
import XCTest
import ConfigureId

final class SessionTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        config = try TestConfig.prod()
        ConfigureID.setHost(host: config.host)
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
    func testCreateSession() {
        let products = expectation(description: "should create session")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Sessions
            .createSession(
                locale: "en_US",
                customerId: config.customerId,
                productId: config.productId,
                workflow: config.workflow,
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
                sessionId: config.sessionId,
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
                sessionId: config.sessionId,
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
    
    func testUpdateRecipe() {
        let updateRecipe = expectation(description: "should update recipe")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Sessions
            .updateRecipe(
                sessionId: config.sessionId,
                includeSummary: true,
                updates: [
                    UpdateRecipeAttributes(
                        op: "selectValue",
                        configurableAttribute: .string("default"),
                        attributeValue: .string("98231")
                    )
                ],
                onSuccess: {
                    print($0)
                    updateRecipe.fulfill()
                },
                onError: {
                    XCTFail(error: $0)
                    updateRecipe.fulfill()
                }
            )

        waitForExpectations(timeout: 10)
    }
}

func XCTFail(error: Error, file: StaticString = #filePath, line: UInt = #line) {
    XCTFail(error.localizedDescription, file: file, line: line)
}