//
//  ConfigureIdData.swift
//  
//
//  Created by Francisco D. on 07/06/2022.
//

import ConfigureId

struct ConfigureIdData {

    let session: Session
    
    let customerId: Int
    
    let productId: Int
    
    let environment: String?
    
    let workflow: String
    
    init(session: Session, customerId: Int, productId: Int, environment: String?, workflow: String) {
        self.session = session
        self.customerId = customerId
        self.productId = productId
        self.environment = environment
        self.workflow = workflow
    }
    
    init(data: ConfigureIdData, session: Session? = nil, customerId: Int? = nil, productId: Int? = nil, environment: String?? = nil, workflow: String? = nil) {
        self.session = session ?? data.session
        self.customerId = customerId ?? data.customerId
        self.productId = productId ?? data.productId
        self.environment = environment ?? data.environment
        self.workflow = workflow ?? data.workflow
    }
}
