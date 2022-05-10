import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        config = try TestConfig.prod()
        ConfigureID.environment = config.environment
        ConfigureID.setApiKey(apiKey: config.apiKey)
    }
    
    func testFetchProducts() {
        let productsExpectation = expectation(description: "should fetch products")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Customers
            .fetchProducts(
                customerId: config.customerId,
                workflow: config.workflow,
                onSuccess: { (products: [ProductSummary]) in
                    print(products)
                    productsExpectation.fulfill()
                },
                onError: { (error: ConfigureIDError) in
                    XCTFail(error: error)
                    productsExpectation.fulfill()
                }
            )
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchProductData() {
        let product = expectation(description: "Load product data")

        waitFor(seconds: 2)
    
        ConfigureID
            .Customers
            .fetchProductData(
                customerId: config.customerId,
                productId: config.productId,
                workflow: config.workflow,
                onSuccess: {
                    print($0)
                    product.fulfill()
                }, onError: {
                    XCTFail(error: $0)
                    product.fulfill()
                }
            )

        waitForExpectations(timeout: 10)
    }

    func testFindByVendorId() {
        let findByVendor = expectation(description: "Find by vendor id")

        waitFor(seconds: 2)

        ConfigureID.Customers
            .fetchProducts(
                customerId: config.customerId,
                workflow: config.workflow,
                vendorId: config.vendorId,
                onSuccess: {
                    print($0)
                    findByVendor.fulfill()
                }, onError: {
                    XCTFail(error: $0)
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
