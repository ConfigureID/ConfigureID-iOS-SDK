//
//  ExampleViewModel.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 07/06/2022.
//

import Combine
import ConfigureId

class ExampleViewModel {
    
    let sessionPublisher: AnyPublisher<ConfigureIdData, Never>
    
    let updatedRecipe: AnyPublisher<ConfigureIdData, Never>
    
    init(selectedExample: AnyPublisher<Int, Never>) {
        sessionPublisher = selectedExample
            .filter { $0 == SelectedExample.image.rawValue || $0 == SelectedExample.webgl.rawValue }
            .map { SelectedExample(rawValue: $0)!.config }
            .handleEvents(receiveOutput: { config in
                ConfigureId.setApiKey(apiKey: config.apiKey)
            })
            .map { config in
                // TODO: What if session doesn't exist
                resetSession(sessionId: config.sessionId)
                    .flatMap { _ in
                        fetchSession(sessionId: config.sessionId)
                            .map { session in
                                ConfigureIdData(typeToRender: .fetchSession, session: session, customerId: config.customerId, productId: config.productId)
                            }
                    }
                    .catch { error -> AnyPublisher<ConfigureIdData, Never> in
                        print(error)
                        return Empty().eraseToAnyPublisher()
                    }

            }
            .switchToLatest()
            .share()
            .print("---> sessionPublisher")
            .eraseToAnyPublisher()
        
        updatedRecipe = selectedExample
            .filter { index in index == SelectedExample.extra.rawValue }
            .print("---> updateRecipe")
            .withLatestFrom(
                sessionPublisher,
                resultSelector: { _, sessionData in
                    sessionData
                }
            )
            .map { data in
                return updateRecipe(data: data)
                    .map { session in ConfigureIdData(typeToRender: .updateRecipe, session: session, customerId: data.customerId, productId: data.productId) }
                    .catch { error -> AnyPublisher<ConfigureIdData, Never> in
                        print(error)
                        return Empty().eraseToAnyPublisher()
                    }
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
