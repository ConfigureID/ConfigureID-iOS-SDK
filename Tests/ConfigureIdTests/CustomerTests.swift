import XCTest
import ConfigureId

final class ConfigureID_iOS_SDKTests: XCTestCase {
    
    var config: TestConfig!
    
    override func setUpWithError() throws {
        config = try TestConfig.current()
        ConfigureId.setHost(host: config.host)
        ConfigureId.setApiKey(apiKey: config.apiKey)
    }
    
    func testFetchProducts() {
        let productsExpectation = expectation(description: "should fetch products")
        
        waitFor(seconds: 2)
        
        ConfigureId
            .Customers
            .fetchProducts(
                customerId: config.customerId,
                workflow: config.workflow,
                onSuccess: { (products: [ProductReport]) in
                    print(products)
                    productsExpectation.fulfill()
                },
                onError: { (error: ConfigureIdError) in
                    XCTFail(error: error)
                    productsExpectation.fulfill()
                }
            )
        
        waitForExpectations(timeout: 10)
    }
    
    func testFetchProductData() {
        let product = expectation(description: "Load product data")

        waitFor(seconds: 2)
    
        ConfigureId
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

        ConfigureId.Customers
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
