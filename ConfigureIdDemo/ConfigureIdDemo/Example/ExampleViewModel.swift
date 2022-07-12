//
//  ExampleViewModel.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 07/06/2022.
//

import Combine
import ConfigureId

class ExampleViewModel {
    
    let exampleSelected: AnyPublisher<(), Never>
    
    let showOptionsMenu: AnyPublisher<ConfigureIdData, Never>
    
    init(selectedExample: AnyPublisher<Int, Never>) {
        exampleSelected = selectedExample
            .filter { $0 == SelectedExample.image.rawValue || $0 == SelectedExample.webgl.rawValue }
            .map { SelectedExample(rawValue: $0)!.config }
            .handleEvents(receiveOutput: { config in
                ConfigureId.setApiKey(apiKey: config.apiKey)
                Context.shared.viewName.value = nil
            })
            .map { config in
                // TODO: What if session doesn't exist
                resetSession(sessionId: config.sessionId)
                    .flatMap { _ in
                        fetchSession(sessionId: config.sessionId)
                            .map { session in
                                ConfigureIdData(
                                    session: session,
                                    customerId: config.customerId,
                                    productId: config.productId,
                                    environment: config.environment,
                                    workflow: config.workflow
                                )
                            }
                    }
                    .catch { error -> AnyPublisher<ConfigureIdData, Never> in
                        print(error)
                        return Empty().eraseToAnyPublisher()
                    }

            }
            .switchToLatest()
            .share()
            .handleEvents(receiveOutput: { data in
                Context.shared.data = data
            })
            .map { _ in }
            .eraseToAnyPublisher()
        
        showOptionsMenu = selectedExample
            .filter { index in index == SelectedExample.extra.rawValue }
            .withLatestFrom(
                Context.shared.$data.compactMap { $0 },
                resultSelector: { _, sessionData in
                    sessionData
                }
            )
            .eraseToAnyPublisher()
    }
}
