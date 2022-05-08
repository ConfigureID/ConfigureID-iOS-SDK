//
//  ConfigureID.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    /// Customers endpoints
    struct Customers {
        
        /// Retrieves all products of a customer.
        /// - Parameters:
        ///   - customerId: Id of a customer.
        ///   - workflow: The workflow identifier.
        ///   - vendorId: The vendor id of the product.
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
        public static func fetchProducts(
            customerId: Int,
            workflow: String? = nil,
            vendorId: String? = nil,
            onSuccess: @escaping ([ProductSummary]) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                let request = try Request.Customer.products(
                    customerId: customerId,
                    workflow: workflow,
                    vendorId: vendorId
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                handleError(error: error, onError: onError)
            }
        }
        
        /// Retrieves the data of a product.
        /// - Parameters:
        ///   - customerId: Id of a customer.
        ///   - productId: Id of a product.
        ///   - workflow: The workflow identifier.
        ///   - onSuccess: Callback that will be run on success.
        ///   - onError: Callback that will be run on error.
        public static func fetchProductData(
            customerId: Int,
            productId: Int,
            workflow: String? = nil,
            onSuccess: @escaping (Product) -> (),
            onError: @escaping (ConfigureIDError) -> ()
        ) {
            do {
                
                let request = try Request.Customer.productData(
                    customerId: customerId,
                    productId: productId,
                    workflow: workflow
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                handleError(error: error, onError: onError)
            }
        }
    }
}
