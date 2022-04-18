import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(ConfigureID_iOS_SDK().text, "Hello, World!")
        let products = expectation(description: "Load products")
        let product = expectation(description: "Load product data")
        let findByVendor = expectation(description: "Find by vendor id")
        // TODO: Remove this (Rewrite git history)
        ConfigureID.setApiKey(apiKey: "<API_KEY>")
        
        ConfigureID
            .Customers
            .fetchProducts(customerId: "1622", workflow: "dev", onSuccess: {
                print($0)
                products.fulfill()
            }, onError: {
                print($0)
                products.fulfill()
            })
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Customers
            .fetchProductData(customerId: "1622", productId: "24253", workflow: "dev", onSuccess: {
                print($0)
                product.fulfill()
            }, onError: {
                print($0)
                product.fulfill()
            })
        
        waitFor(seconds: 2)

        ConfigureID.Customers
            .findByVendorId(
                customerId: "1622",
                vendorId: "CUSTOM FITTED",
                workflow: "dev",
                onSuccess: {
                    print($0)
                    findByVendor.fulfill()
                }, onError: {
                    print($0)
                    findByVendor.fulfill()
                }
            )
        
        waitFor(seconds: 2)

        waitForExpectations(timeout: 20)
        
    }
    

}

extension XCTestCase {
    
    func waitFor(seconds: Double) {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: seconds)
    }
}
