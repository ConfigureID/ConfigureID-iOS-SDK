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
        config = try TestConfig.current()
        ConfigureId.setHost(host: config.host)
        ConfigureId.setApiKey(apiKey: config.apiKey)
    }
    
    func testCreateSession() {
        let products = expectation(description: "should create session")
        
        waitFor(seconds: 2)
        
        ConfigureId
            .Sessions
            .createSession(
                locale: "en_us",
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
        
        ConfigureId
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
        
        ConfigureId
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
        
        ConfigureId
            .Sessions
            .updateRecipe(
                sessionId: config.sessionId,
                includeSummary: true,
                updates: [
                    UpdateRecipeAttributes(
                        op: "selectValue",
                        configurableAttribute: .int(33951),
                        attributeValue: .int(44852)
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
