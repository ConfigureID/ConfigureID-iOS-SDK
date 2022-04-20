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
    
    func executeRequest<T: Codable>(request: Request, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) {
        guard let urlRequest = request.urlRequest() else {
            print("Invalid URL ", request)
            // TODO: return error
            return
        }
        let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    onError(error)
                }
                
                if let data = data {
                    do {
                        let decoded: Response<T> = try Environment.decoder.decode(Response<T>.self, from: data)
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
