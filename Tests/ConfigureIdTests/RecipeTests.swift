//
//  RecipeTests.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation
import XCTest
import ConfigureId

final class RecipeTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        config = try TestConfig.prod()
        ConfigureId.setHost(host: config.host)
        ConfigureId.setApiKey(apiKey: config.apiKey)
    }
    
    func testCreateRecipe() {
        let createRecipeExpectation = expectation(description: "should create recipe")

        waitFor(seconds: 2)
        
        ConfigureId
            .Recipes
            .createRecipe(
                sessionId: config.sessionId,
                quantity: nil,
                purpose: nil,
                addToCatalog: nil,
                catalogs: nil,
                onSuccess: {
                    print($0)
                    createRecipeExpectation.fulfill()
                },
                onError: {
                    XCTFail(error: $0)
                    createRecipeExpectation.fulfill()
                }
            )

        waitForExpectations(timeout: 10)
    }
    
    func testRetrieveRecipe() {
        let retrieveExpectation = expectation(description: "should retrieve recipe")

        waitFor(seconds: 2)
        
        ConfigureId
            .Recipes
            .fetchRecipe(
                recipeId: config.recipeId,
                locale: "en_US",
                includeLocalizedConfiguration: false,
                includeExtendedAttributes: false,
                onSuccess: {
                    print($0)
                    retrieveExpectation.fulfill()
                },
                onError: {
                    XCTFail(error: $0)
                    retrieveExpectation.fulfill()
                }
            )

        waitForExpectations(timeout: 10)
    }
}
