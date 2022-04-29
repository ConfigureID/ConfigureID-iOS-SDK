//
//  File.swift
//  
//
//  Created by Francisco D. on 21/04/2022.
//

import Foundation

public enum ConfigureIDError: Error {
    case invalidURL
    case encodingError(entity: String)
    case decodingError(entity: String)
    // TODO: revisit naming
    case serverError(statusCode: Int, details: [String])
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
        case .encodingError(_):
            return -4
        case .unexpectedError:
            return -5
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
        case .decodingError(let entity):
            return ["Could not decode \(entity) from response"]
        case .encodingError(entity: let entity):
            return ["Could not encode \(entity)"]
        case .unexpectedError:
            return ["This error should not have happened"]
        }
    }
}

extension ConfigureIDError: LocalizedError {
    public var errorDescription: String? {
        return "\(self.statusCode): \(self.details)"
    }
}
