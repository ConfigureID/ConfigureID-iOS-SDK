//
//  ImageParameters.swift
//  
//
//  Created by Francisco D. on 20/04/2022.
//

import Foundation

struct ImageParameters: Codable {

    let binary: Bool
    let zoom: Bool
    let format: String
    let trim: Bool
    let padding: Int
    let scale: Int
    let quality: Int
    let backgroundColor: String
    let viewName: String
    
}
