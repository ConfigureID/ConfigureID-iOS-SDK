//
//  SelectedExample.swift
//  
//
//  Created by Francisco D. on 07/06/2022.
//

import Foundation

enum SelectedExample: Int, Equatable {
    case image
    case webgl
    case extra
    
    var config: TestConfig {
        switch self {
        case .image:
            return try! TestConfig.prod2dProduct()
        case .webgl:
            return try! TestConfig.prod3dProduct()
        case .extra:
            return try! TestConfig.prod3dProduct()
        }
    }
}
