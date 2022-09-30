//
//  Collection.swift
//  UI
//
//  Created by JMY on 2022/02/11.
//

import Foundation

extension Collection {
    subscript(optional i: Index) -> Bool {
        return indices.contains(i)
    }

    subscript(optional i: Index) -> Iterator.Element? {
        return indices.contains(i) ? self[i] : nil
    }

    // MARK: - JSONSerialization

    /// https://stackoverflow.com/questions/38773979/is-there-a-way-to-pretty-print-swift-dictionaries-to-the-console

    func format(options: JSONSerialization.WritingOptions) -> Any? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return try JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments])
        } catch {
            error.localizedDescription.log()
            return nil
        }
    }

    func toJSONData(options: JSONSerialization.WritingOptions = .prettyPrinted) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch {
            error.localizedDescription.log()
            return nil
        }
    }

    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        guard let jsonData = toJSONData(options: options) else {
            return "{}"
        }

        return String(data: jsonData, encoding: .utf8) ?? "{}"
    }
}
