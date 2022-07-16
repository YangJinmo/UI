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

    // MARK: - Convert JSON

    /// https://stackoverflow.com/questions/38773979/is-there-a-way-to-pretty-print-swift-dictionaries-to-the-console

    func toJSONString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }

        let options = prettify
            ? JSONSerialization.WritingOptions.prettyPrinted
            : JSONSerialization.WritingOptions()

        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: options)
            return String(data: data, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }

    func toJSONData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }

        let options = prettify
            ? JSONSerialization.WritingOptions.prettyPrinted
            : JSONSerialization.WritingOptions()

        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
}
