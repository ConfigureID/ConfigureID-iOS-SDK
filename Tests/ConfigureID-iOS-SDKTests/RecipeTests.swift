//
//  RecipeTests.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation
import XCTest
@testable import ConfigureID_iOS_SDK

final class RecipeTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        config = try TestConfig.loadFrom(fileName: "prod-config.json")
        ConfigureID.environment = config.environment
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
    func testCreateRecipe() {
        let createRecipeExpectation = expectation(description: "should create recipe")

        waitFor(seconds: 2)
        
        ConfigureID
            .Recipes
            .createRecipe(
                sessionId: "335e430c-a32b-4511-9712-7c9045c64143",
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
        
        ConfigureID
            .Recipes
            .fetchRecipe(
                recipeId: "",
                locale: "",
                includeLocalizedConfiguration: true,
                includeExtendedAttributes: true,
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
