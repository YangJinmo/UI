//
//  DecodingError.swift
//  UI
//
//  Created by Jmy on 2023/04/02.
//

import Foundation

extension DecodingError {
    /// Concats the CodingKeys to provide a key path string
    static func codingKeyAsPrefixString(from codingKeys: [CodingKey]) -> String {
        return codingKeys.map({ $0.stringValue }).joined(separator: ".")
    }

    /// Returns a human readable error description from a `DecodingError`, useful for returning back to clients to help them debug their malformed JSON objects.
    public var description: String {
        switch self {
        case let .valueNotFound(value, context):
            return "Value '\(value)' not found: Key '\(DecodingError.codingKeyAsPrefixString(from: context.codingPath))' has the wrong type or was not found. \(context.debugDescription)"

        case let .keyNotFound(key, context):
            var prefixString = DecodingError.codingKeyAsPrefixString(from: context.codingPath)

            if prefixString.count > 0 {
                prefixString = "\(prefixString)."
            }

            return "The required key '\(prefixString)\(key.stringValue)' not found."

        case let .dataCorrupted(context):
            // Linux does not get to this state but sends an Error "The operation could not be completed" instead. Future proofing this though just in case.
            #if !os(Linux) || swift(>=4.1.50)
                if let nsError = context.underlyingError as NSError?, let detailedError = nsError.userInfo["NSDebugDescription"] as? String {
                    return "The JSON appears to be malformed. \(detailedError)"
                }
            #else
                // Linux (prior to 4.2) needs a conditional downcast
                if let nsError = context.underlyingError as? NSError, let detailedError = nsError.userInfo["NSDebugDescription"] as? String {
                    return "The JSON appears to be malformed. \(detailedError)"
                }
            #endif
            return "The JSON appears to be malformed."

        case let .typeMismatch(type, context):
            return "Type '\(type)' mismatch: Key '\(DecodingError.codingKeyAsPrefixString(from: context.codingPath))' has the wrong type. \(context.debugDescription)"

        #if swift(>=5.0)
            @unknown default:
                return "An unknown DecodingError occurred: \(self)"
        #endif
        }
    }

    public func simpleDescription() {
        switch self {
        case let .dataCorrupted(context):
            print("Context: \(context)")

        case let .keyNotFound(codingKey, context):
            print("CodingKey '\(codingKey.stringValue)' not found.")
            print("Context: \(context.debugDescription)")
            print("CodingPath:", DecodingError.codingKeyAsPrefixString(from: context.codingPath))

        case let .typeMismatch(type, context):
            print("Type mismatch for type '\(type)'")
            print("Context: \(context.debugDescription)")
            print("CodingPath:", DecodingError.codingKeyAsPrefixString(from: context.codingPath))

        case let .valueNotFound(type, context):
            print("Value not found for type '\(type)'")
            print("Context: \(context.debugDescription)")
            print("CodingPath:", DecodingError.codingKeyAsPrefixString(from: context.codingPath))

        default:
            print("Error decoding JSON: \(self)")
        }
    }
}
