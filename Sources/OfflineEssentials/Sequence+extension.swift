//
//  Sequence+extension.swift
//  Post2
//
//  Created by Justin Allen on 8/4/23.
//

import Foundation

@available(iOS 13.0.0, *)
extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}


@available(iOS 13.0.0, *)
extension Sequence {
    func asyncForEach(
        _ body: (Int, Element) async throws -> Void
    ) async rethrows {
        for (index, element) in self.enumerated() {
            try await body(index, element)
        }
    }
}
