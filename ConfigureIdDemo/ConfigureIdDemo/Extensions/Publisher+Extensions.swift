//
//  Publisher+Extensions.swift
//  ConfigureIdDemo
//
//  Created by Francisco D. on 05/06/2022.
//

import Combine

extension Array where Element: Publisher {
    
    func merged() -> Publishers.MergeMany<Element> {
        return Publishers.MergeMany(self)
    }
    
}

extension Publisher {
  func withLatestFrom<Other: Publisher, Result>(_ other: Other,
                                                    resultSelector: @escaping (Output, Other.Output) -> Result)
      -> AnyPublisher<Result, Failure>
      where Other.Failure == Failure {
          let upstream = share()
  
          return other
              .map { second in upstream.map { resultSelector($0, second) } }
              .switchToLatest()
              .zip(upstream) // `zip`ping and discarding `\.1` allows for
                                        // upstream completions to be projected down immediately.
              .map(\.0)
              .eraseToAnyPublisher()
      }
}
