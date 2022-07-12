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

extension Publisher {

    /// Includes the current element as well as the previous element from the upstream publisher in a tuple where the previous element is optional.
    /// The first time the upstream publisher emits an element, the previous element will be `nil`.
    ///
    ///     let range = (1...5)
    ///     cancellable = range.publisher
    ///         .withPrevious()
    ///         .sink { print ("(\($0.previous), \($0.current))", terminator: " ") }
    ///      // Prints: "(nil, 1) (Optional(1), 2) (Optional(2), 3) (Optional(3), 4) (Optional(4), 5) ".
    ///
    /// - Returns: A publisher of a tuple of the previous and current elements from the upstream publisher.
    func withPrevious() -> AnyPublisher<(previous: Output?, current: Output), Failure> {
        scan(Optional<(Output?, Output)>.none) { ($0?.1, $1) }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    /// Includes the current element as well as the previous element from the upstream publisher in a tuple where the previous element is not optional.
    /// The first time the upstream publisher emits an element, the previous element will be the `initialPreviousValue`.
    ///
    ///     let range = (1...5)
    ///     cancellable = range.publisher
    ///         .withPrevious(0)
    ///         .sink { print ("(\($0.previous), \($0.current))", terminator: " ") }
    ///      // Prints: "(0, 1) (1, 2) (2, 3) (3, 4) (4, 5) ".
    ///
    /// - Parameter initialPreviousValue: The initial value to use as the "previous" value when the upstream publisher emits for the first time.
    /// - Returns: A publisher of a tuple of the previous and current elements from the upstream publisher.
    func withPrevious(_ initialPreviousValue: Output) -> AnyPublisher<(previous: Output, current: Output), Failure> {
        scan((initialPreviousValue, initialPreviousValue)) { ($0.1, $1) }.eraseToAnyPublisher()
    }
}
