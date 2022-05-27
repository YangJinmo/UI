//
//  Collection.swift
//  UI
//
//  Created by JMY on 2022/02/11.
//

import Foundation

extension Collection {
    subscript(optional i: Index) -> Bool {
        indices.contains(i)
    }

    subscript(optional i: Index) -> Iterator.Element? {
        indices.contains(i) ? self[i] : nil
    }

    /// Convert self to JSON String.
    /// Returns: the pretty printed JSON string or an empty string if any error occur.
    /// https://stackoverflow.com/questions/38773979/is-there-a-way-to-pretty-print-swift-dictionaries-to-the-console
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }
}
