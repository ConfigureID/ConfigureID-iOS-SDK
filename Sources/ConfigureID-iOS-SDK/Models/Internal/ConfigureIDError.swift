//
//  File.swift
//  
//
//  Created by Francisco D. on 21/04/2022.
//

import Foundation

enum ConfigureIDError: Error {
    case error(status: Int, details: String)
    case invalidURL
    case unknownError(Error)
}

extension ConfigureIDError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error(let status, let details):
            return "\(status): \(details)"
            
        case .invalidURL:
            return "Invalid URL provided"
            
        case .unknownError(let error):
            return error.localizedDescription
        }
    }
}
