//
//  Dictionary.swift
//  UI
//
//  Created by JMY on 2022/05/27.
//

extension Dictionary where Key: CustomDebugStringConvertible, Value: CustomDebugStringConvertible {
    var prettyprint: String {
        for (key, value) in self {
            print("\(key) = \(value)")
        }

        return description
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    var prettyPrint: String {
        return String(describing: self as AnyObject)
    }
}
