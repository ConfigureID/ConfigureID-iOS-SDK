//
//  File.swift
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
    
    func get<T: Codable>(url: String, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) {
        guard let url = URL(string: url) else {
            // TODO
            print("Invalid URL")
            return
        }
        
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
        
    static let baseURL = "https://headless.fluidconfigure.com"
    
    struct Customer {
        
        static func products(customerId: String, apiKey: String, workflow: String) -> String {
            return "\(baseURL)/customers/\(customerId)/products?api-key=\(apiKey)&workflow=\(workflow)"
        }
    }
}

public struct CustomerEndpoints {
    
    public func fetchProducts(customerId: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (Error) -> ()) {
        let endpoint = Endpoints.Customer.products(
            customerId: customerId,
            apiKey: "<CHANGE_ME>",
            workflow: "dev"
        )
        
        print(endpoint)
        
        NetworkManager
            .shared
            .get(
                url: endpoint,
                onSuccess: onSuccess,
                onError: onError
            )
    }
    
}
