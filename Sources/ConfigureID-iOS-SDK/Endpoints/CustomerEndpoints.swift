//
//  Endpoints.swift
//  
//
//  Created by Francisco D. on 12/04/2022.
//

import Foundation

struct Response<T: Codable>: Codable {
    let data: T
}

// TODO: How will I manage errors?
class NetworkManager {
    
//    private let session = URLSession.shared
    
    private let session: URLSession
    
    static let shared: NetworkManager = NetworkManager()
    
    init() {
        // TODO: Check if we want ephemeral, this is to avoid a 304
        session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    }
    
    func GET<T: Codable>(url: URL, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) {
        let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    onError(error)
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decoded: Response<T> = try decoder.decode(Response<T>.self, from: data)
                        onSuccess(decoded.data)
                    } catch {
                        // TODO
                        print("Error occurred get: \(error)")
                    }
                }
            }
        
        task.resume()
        
    }
}

struct Endpoints {
        
    // TODO: allow to modify this
    static let baseURL = "https://headless.fluidconfigure.com"
    
    struct Customer {
        
        static func products(customerId: String, apiKey: String, workflow: String) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return components.url
        }
        
        static func productData(customerId: String, productId: String, apiKey: String, workflow: String) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products/\(productId)"

            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
            
            return components.url
        }
        
        static func findByVendorId(customerId: String, apiKey: String, vendorId: String, workflow: String) -> URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "headless.fluidconfigure.com"
            components.path = "/customers/\(customerId)/products/find-by-vendor-id/\(vendorId)"
            components.queryItems = [
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "workflow", value: workflow)
            ]
        
            return components
        }
    }
}

// TODO: Maybe we don't need this class
public struct CustomerEndpoints {
    
    // TODO: Document
    static func fetchProducts(apiKey: String, customerId: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
        let endpoint = Endpoints.Customer.products(
            customerId: customerId,
            apiKey: apiKey,
            // TODO: send as parameter
            workflow: "dev"
        )
        
        NetworkManager
            .shared
            .GET(
                // TODO
                url: endpoint!,
                onSuccess: onSuccess,
                onError: onError
            )
    }
    
    // TODO: Document
    static func fetchProductData(apiKey: String, customerId: String, productId: String, onSuccess: @escaping (Product) -> (), onError: @escaping (Error) -> ()) {
        let endpoint = Endpoints.Customer.productData(
            customerId: customerId,
            productId: productId,
            // TODO: send as parameter
            apiKey: "<API_KEY>",
            // TODO: send as parameter
            workflow: "dev"
        )
        
        NetworkManager
            .shared
            .GET(
                url: endpoint!,
                onSuccess: onSuccess,
                onError: onError
            )
    }
}
