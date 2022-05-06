//
//  ConfigureIDError.swift
//  
//
//  Created by Francisco D. on 21/04/2022.
//

import Foundation

public enum ConfigureIDError: Error {
    case invalidURL
    case encodingError(entity: String, originalError: Error?)
    case decodingError(entity: String, originalError: Error?)
    // TODO: revisit naming
    case serverError(statusCode: Int, details: [String])
    case notAuthenticated
    case unknownError(Error)
    case unexpectedError
    
    var statusCode: Int {
        switch self {
        case .serverError(let code, _):
            return code
        case .invalidURL:
            return -1
        case .unknownError:
            return -2
        case .decodingError:
            return -3
        case .encodingError:
            return -4
        case .unexpectedError:
            return -5
        case .notAuthenticated:
            return -6
        }
    }
    
    var details: [String] {
        switch self {
        case .serverError(_, let details):
            return details
        case .unknownError(let error):
            return [error.localizedDescription]
        case .invalidURL:
            return ["Invalid URL provided"]
        case .decodingError(let entity, let originalError):
            return ["Could not decode \(entity) from response"] +
                    (originalError.map { ["\($0)"] } ?? [])
        case .encodingError(entity: let entity, let originalError):
            return ["Could not encode \(entity)"] +
                    (originalError.map { ["\($0)"] } ?? [])
        case .unexpectedError:
            return ["This error should not have happened"]
        case .notAuthenticated:
            return ["apiKey not set. Did you call ConfigureID.setApiKey(apiKey: ...)?"]
        }
    }
}

extension ConfigureIDError: LocalizedError {
    public var errorDescription: String? {
        return "\(self.statusCode): \(self.details)"
    }
}
