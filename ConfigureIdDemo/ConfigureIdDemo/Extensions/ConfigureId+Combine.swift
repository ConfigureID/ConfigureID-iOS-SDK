//
//  ViewController.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 05/06/2022.
//

import UIKit
import Combine
import ConfigureId

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