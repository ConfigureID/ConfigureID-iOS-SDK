import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(ConfigureID_iOS_SDK().text, "Hello, World!")
        let exp = expectation(description: "Loading stories")
        
        CustomerEndpoints()
            .fetchProducts(customerId: "1622", onSuccess: {
                print($0)
                exp.fulfill()
            }, onError: {
                print($0)
                exp.fulfill()
            })
        
        waitForExpectations(timeout: 10)

    }
}
