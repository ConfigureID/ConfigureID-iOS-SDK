//
//  Context.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 12/07/2022.
//

import Foundation
import Combine

class Context {

    static let shared = Context()

    @Published var data: ConfigureIdData? = nil
    
    let viewName = CurrentValueSubject<String?, Never>(nil)
    
    var available3DViews: [String] {
        guard let data = self.data else {
            return []
        }
        
        switch data.productId {
        case 23938:
            return ["Front", "Back", "Top"]
        default:
            break
        }
        
        return []
    }
    
    var attributeListToBeUpdated: [Int] {
        guard let data = self.data else {
            return []
        }
        
        switch data.productId {
        case 23938:
            return [90069, 90070, 90068]
        case 24252:
            return [93755, 93776]
        case 23770:
            return [88191, 88195]
        case 21615:
            return [52163, 52170, 52164, 52165]
        default:
            return []
        }
    }
}
