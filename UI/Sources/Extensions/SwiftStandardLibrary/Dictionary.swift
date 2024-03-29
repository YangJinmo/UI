//
//  Dictionary.swift
//  UI
//
//  Created by JMY on 2022/05/27.
//

extension Dictionary where Key: CustomDebugStringConvertible, Value: CustomDebugStringConvertible {
    func prettyPrint(prefixLetter: String = "") {
        for (key, value) in self {
            print("\(prefixLetter)\(key): \(value)")
        }
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    var asAnyObject: String {
        return String(describing: self as AnyObject)
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral {
    ///  Merge the keys/values of two dictionaries.
    ///
    ///        let dict : [String : String] = ["key1" : "value1"]
    ///        let dict2 : [String : String] = ["key2" : "value2"]
    ///        let result = dict + dict2
    ///        result["key1"] -> "value1"
    ///        result["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    /// - Returns: An dictionary with keys and values from both.
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }

    // MARK: - Operators

    ///  Append the keys and values from the second dictionary into the first one.
    ///
    ///        var dict : [String : String] = ["key1" : "value1"]
    ///        let dict2 : [String : String] = ["key2" : "value2"]
    ///        dict += dict2
    ///        dict["key1"] -> "value1"
    ///        dict["key2"] -> "value2"
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: dictionary
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach({ lhs[$0] = $1 })
    }

    ///  Remove contained in the array from the dictionary
    ///
    ///        let dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        let result = dict-["key1", "key2"]
    ///        result.keys.contains("key3") -> true
    ///        result.keys.contains("key1") -> false
    ///        result.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    /// - Returns: a new dictionary with keys removed.
    static func - (lhs: [Key: Value], keys: [Key]) -> [Key: Value] {
        var result = lhs
        result.removeAll(keys: keys)
        return result
    }

    ///  Remove contained in the array from the dictionary
    ///
    ///        var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict-=["key1", "key2"]
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameters:
    ///   - lhs: dictionary
    ///   - rhs: array with the keys to be removed.
    static func -= (lhs: inout [Key: Value], keys: [Key]) {
        lhs.removeAll(keys: keys)
    }

    ///  Lowercase all keys in dictionary.
    ///
    ///     var dict = ["tEstKeY": "value"]
    ///     dict.lowercaseAllKeys()
    ///     print(dict) // prints "["testkey": "value"]"
    mutating func lowercaseAllKeys() {
        for key in keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = removeValue(forKey: key)
            }
        }
    }

    /// Check if key exists in dictionary.
    ///
    ///        let dict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///        dict.has(key: "testKey") -> true
    ///        dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for
    /// - Returns: true if key exists in dictionary.
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    ///  Remove all keys of the dictionary.
    ///
    ///        var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict.removeAll(keys: ["key1", "key2"])
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed
    mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0) })
    }
}

extension Dictionary {
    func queryPrint() {
        for (key, value) in self {
            print(" - \(key): \(value)")
        }
    }

    func prettyPrint(prefixLetter: String = "\t") {
        print()
        print("[")

        for (key, value) in self {
            print("\(prefixLetter)\(key): \(value)")
        }

        print("]")
        print()
    }

    func printAnyObject() {
        print(self as AnyObject)
    }
}
