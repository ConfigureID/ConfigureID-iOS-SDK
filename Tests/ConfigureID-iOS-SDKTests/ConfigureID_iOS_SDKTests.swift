import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        ConfigureID.environment = .staging
        config = try TestConfig.loadFrom(fileName: "staging-config.json")
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
    func testFetchProducts() {
        let products = expectation(description: "should fetch products")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Customers
            .fetchProducts(customerId: config.customerId, workflow: "dev", onSuccess: {
                print($0)
                products.fulfill()
            }, onError: {
                print($0)
                products.fulfill()
            })
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchProductData() {
        let product = expectation(description: "Load product data")

        waitFor(seconds: 2)

        ConfigureID
            .Customers
            .fetchProductData(customerId: config.customerId, productId: config.productId, workflow: "dev", onSuccess: {
                print($0)
                product.fulfill()
            }, onError: {
                print($0)
                product.fulfill()
            })

        waitForExpectations(timeout: 10)
    }

    func testFindByVendorId() {
        let findByVendor = expectation(description: "Find by vendor id")

        waitFor(seconds: 2)

        ConfigureID.Customers
            .findByVendorId(
                customerId: config.customerId,
                vendorId: config.vendorId,
                workflow: "dev",
                onSuccess: {
                    print($0)
                    findByVendor.fulfill()
                }, onError: {
                    print($0)
                    findByVendor.fulfill()
                }
            )

        waitForExpectations(timeout: 10)
    }
    
}

extension XCTestCase {
    
    func waitFor(seconds: Double) {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: seconds)
    }
}
