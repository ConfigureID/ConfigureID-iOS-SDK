//
//  Bool+Extensions.swift
//  
//
//  Created by Francisco D. on 09/05/2022.
//

import Foundation

extension Bool {
    
    var asQueryItem: String {
        return "\(self)".lowercased()
    }
    
}
