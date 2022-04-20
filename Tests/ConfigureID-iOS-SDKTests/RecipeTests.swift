//
//  File.swift
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
        config = try TestConfig.loadFrom(fileName: "staging-config.json")
        ConfigureID.environment = config.environment
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
//    func testCreateRecipe() {
//        let products = expectation(description: "should create recipe")
//
//        waitFor(seconds: 2)
//
//        let parameters = CreateRecipeParameters(sessionId: <#T##String#>)
//
//        ConfigureID
//            .Recipes
//            .createRecipe(parameters: <#T##CreateRecipeParameters#>,
//                          onSuccess: {
//                              print($0)
//                              products.fulfill()
//                          },
//                          onError: {
//                              print($0)
//                              products.fulfill()
//                          })
//            .fetchProducts(customerId: config.customerId, workflow: "dev", onSuccess: {
//                print($0)
//                products.fulfill()
//            }, onError: {
//                print($0)
//                products.fulfill()
//            })
//
//        waitForExpectations(timeout: 10)
//    }
}
