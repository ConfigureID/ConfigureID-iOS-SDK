//
//  NetworkService.swift
//  
//
//  Created by Francisco D. on 14/04/2022.
//

import Foundation

// TODO: How will I manage errors?
class NetworkService {
    
    private let session: URLSession
    
    static let shared: NetworkService = NetworkService()
    
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

struct Response<T: Codable>: Codable {
    let data: T
}
