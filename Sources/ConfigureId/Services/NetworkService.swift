//
//  NetworkService.swift
//  
//
//  Created by Francisco D. on 14/04/2022.
//

import Foundation

class NetworkService {
    
    private let session: URLSession
    
    static let shared: NetworkService = NetworkService()
    
    init() {
        let configuration = URLSessionConfiguration.ephemeral
        // A litte bit more time for requests. Default is 60 seconds.
        configuration.timeoutIntervalForRequest = 180
        session = URLSession(configuration: configuration)
    }
    
    func executeRequest<ResponseType: Codable>(
        request: Request,
        onSuccess: @escaping (ResponseType) -> (),
        onError: @escaping (ConfigureIdError) -> ()) {
            
            var urlRequest: URLRequest!
            
            do {
                urlRequest = try request.urlRequest()
            } catch {
                handleError(error: error, onError: onError)
                return
            }
            
            let task = session.dataTask(with: urlRequest) { data, response, responseError in
                if let error = responseError {
                    onError(.unknownError(error))
                    return
                }
                
                var dataDecodingError: Error?
                
                if let data = data {
                    
                    do {
                        let decoded: Response<ResponseType> = try Host.decoder.decode(Response<ResponseType>.self, from: data)
                        onSuccess(decoded.data)
                        return
                    } catch {
                        dataDecodingError = error
                    }
                    
                    do {
                        let decodedError: ServerError = try Host.decoder.decode(ServerError.self, from: data)
                        onError(.serverError(
                            statusCode: decodedError.error.status,
                            details: decodedError.error.details)
                        )
                        return
                    } catch {
                    }
                }
                
                if let response = response as? HTTPURLResponse {
                    let statusCode = response.statusCode
                    
                    switch statusCode {
                    case 200 ..< 300:
                        onError(.decodingError(
                            entity: "\(ResponseType.self)",
                            originalError: dataDecodingError)
                        )
                        return
                    default:
                        break
                    }
                    
                    onError(
                        .serverError(
                            statusCode: statusCode,
                            details: [HTTPURLResponse.localizedString(forStatusCode: statusCode)]
                        )
                    )
                    return
                }
                
                assertionFailure("shouldn't reach here")
                onError(.unexpectedError)
            }
            
            task.resume()
        }
}

struct Response<T: Codable>: Codable {
    let data: T
}

struct ServerError: Codable {
    let error: ServerErrorInner
}

struct ServerErrorInner: Codable {
    let status: Int
    let details: [String]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Int.self, forKey: .status)
        
        var _error: Error?
        
        var _details: [String] = []

        do {
            _details = try values.decode([String].self, forKey: .details)
        } catch {
            _error = error
        }
        
        do {
            _details = [try values.decode(String.self, forKey: .details)]
        } catch {
            
        }
        
        if _details.isEmpty, let _error = _error {
            throw _error
        }
        
        self.details = _details
    }
}
