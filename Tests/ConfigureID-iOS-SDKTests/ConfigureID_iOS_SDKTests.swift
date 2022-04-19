import XCTest
@testable import ConfigureID_iOS_SDK

final class ConfigureID_iOS_SDKTests: XCTestCase {
    
    override class func setUp() {
        ConfigureID.setApiKey(apiKey: "<API_KEY>")
    }
    
    func testFetchProducts() {
        let products = expectation(description: "should fetch products")
        
        waitFor(seconds: 2)
        
        ConfigureID
            .Customers
            .fetchProducts(customerId: "1622", workflow: "dev", onSuccess: {
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
            .fetchProductData(customerId: "1622", productId: "24253", workflow: "dev", onSuccess: {
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
