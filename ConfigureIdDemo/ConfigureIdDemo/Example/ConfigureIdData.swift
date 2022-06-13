//
//  ConfigureIdData.swift
//  
//
//  Created by Francisco D. on 07/06/2022.
//

import ConfigureId

enum ConfigureIdDataType {
    case fetchSession
    case updateRecipe
}

struct ConfigureIdData {
    
    let typeToRender: ConfigureIdDataType
    
    let session: Session
    
    let customerId: Int
    
    let productId: Int
}
