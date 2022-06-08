//
//  ViewController.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 05/06/2022.
//

import UIKit
import Combine
import ConfigureId

extension TestConfig {
    
    static func loadFrom(fileName: String) throws -> TestConfig {
        
        let file = fileName.replacingOccurrences(of: ".json", with: "")
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            throw "Config file \(fileName) for testing doesn't exist"
        }
        
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        return try decoder.decode(TestConfig.self, from: jsonData)
    }
    
    static func current() throws -> TestConfig {
        return try prod3dProduct()
    }

    static func prod2dProduct() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "prod-2d-product.json")
    }

    static func prod3dProduct() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "prod-3d-product.json")
    }

    static func staging() throws -> TestConfig {
        // NOTE: You'll need to create this.
        return try TestConfig.loadFrom(fileName: "staging-config.json")
    }
    
}

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

func updateRecipe(
    sessionId: String,
    includeSummary: Bool,
    updates: [UpdateRecipeAttributes]
) -> AnyPublisher<Session, ConfigureIdError> {
    return Deferred {
        Future<Session, ConfigureIdError> { promise in
            ConfigureId.Sessions.updateRecipe(
                sessionId: sessionId,
                includeSummary: includeSummary,
                updates: updates,
                onSuccess: { promise(.success($0)) },
                onError: { promise(.failure($0)) }
            )
        }
    }.eraseToAnyPublisher()
}

func updateRecipe(data: ConfigureIdData) -> AnyPublisher<Session, ConfigureIdError> {
    let updates: [UpdateRecipeAttributes]
    
    if data.customerId == SelectedExample.image.config.customerId {
        updates = [
            UpdateRecipeAttributes(
                op: "selectValue",
                configurableAttribute: .int(88191),
                attributeValue: .int(202295)
            )
        ]
    } else if data.customerId == SelectedExample.webgl.config.customerId {
        updates = [
            UpdateRecipeAttributes(
                op: "selectValue",
                configurableAttribute: .int(33951),
                attributeValue: .int(44852)
            )
        ]
    } else {
        fatalError("Unrecognized customer id")
    }
    
    return updateRecipe(
        sessionId: data.session.sessionId,
        includeSummary: true,
        updates: updates
    ).eraseToAnyPublisher()
}

func resetSession(sessionId: String) -> AnyPublisher<Session, ConfigureIdError> {
    return Deferred {
        Future<Session, ConfigureIdError> { promise in
            ConfigureId.Sessions.resetSession(
                sessionId: sessionId,
                onSuccess: { promise(.success($0)) },
                onError: { promise(.failure($0)) }
            )
        }
    }.eraseToAnyPublisher()
}

func fetchSession(sessionId: String) -> AnyPublisher<Session, ConfigureIdError> {
    return Deferred {
        Future<Session, ConfigureIdError> { promise in
            ConfigureId.Sessions.fetchSession(
                sessionId: sessionId,
                onSuccess: { promise(.success($0)) },
                onError: { promise(.failure($0)) }
            )
        }
    }.eraseToAnyPublisher()
}



