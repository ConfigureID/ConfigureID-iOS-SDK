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
            do {
                return try TestConfig.prod2dProduct()
            } catch {
                fatalError("Have you added the 2D product details to prod-2d-product.json?")
            }

        case .webgl:
            do {
                return try TestConfig.prod3dProduct()
            } catch {
                fatalError("Have you added the 3D product details to prod-2d-product.json?")
            }

        case .extra:
            return try! TestConfig.prod3dProduct()
        }
    }
}
