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
                updates: updates,
                includeSummary: includeSummary,
                onSuccess: { promise(.success($0)) },
                onError: { promise(.failure($0)) }
            )
        }
    }.eraseToAnyPublisher()
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
