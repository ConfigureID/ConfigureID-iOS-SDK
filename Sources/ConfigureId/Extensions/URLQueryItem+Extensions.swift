//
//  URLQueryItem+Extensions.swift
//  
//
//  Created by Francisco D. on 06/05/2022.
//

import Foundation

extension URLQueryItem {
    
    static func fromOptional(name: String, value: String?) -> URLQueryItem? {
        return value.map { URLQueryItem(name: name, value: $0) }
    }
    
}
