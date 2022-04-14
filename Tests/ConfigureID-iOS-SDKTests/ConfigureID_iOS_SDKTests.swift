import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(ConfigureID_iOS_SDK().text, "Hello, World!")
        let exp = expectation(description: "Loading response")
        // TODO: Remove this (Rewrite git history)
        ConfigureID.setApiKey(apiKey: "<API_KEY>")
        
        
        ConfigureID
            .Customers
            .fetchProducts(customerId: "1622", workflow: "dev", onSuccess: {
                print($0)
                exp.fulfill()
            }, onError: {
                print($0)
                exp.fulfill()
            })
        
//        ConfigureID
//            .Customers
//            .fetchProductData(customerId: "1622", productId: "24253", workflow: "dev", onSuccess: {
//                print($0)
//                exp.fulfill()
//            }, onError: {
//                print($0)
//                exp.fulfill()
//            })
//
//        ConfigureID.Customers
//            .findByVendorId(
//                customerId: "1622",
//                vendorId: "CUSTOM FITTED",
//                workflow: "dev",
//                onSuccess: {
//                    print($0)
//                    exp.fulfill()
//                }, onError: {
//                    print($0)
//                    exp.fulfill()
//                }
//            )

        waitForExpectations(timeout: 10)
        
    }
}
