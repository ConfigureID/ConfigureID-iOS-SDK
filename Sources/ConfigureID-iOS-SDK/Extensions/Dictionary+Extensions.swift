//
//  Dictionary+Extensions.swift
//  
//
//  Created by Francisco D. on 04/05/2022.
//

import Foundation

extension Dictionary {
    func toJSON() throws -> Data {
        try JSONSerialization.data(withJSONObject: self)
    }
}
