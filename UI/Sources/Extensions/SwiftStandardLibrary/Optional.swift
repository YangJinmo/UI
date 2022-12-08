//
//  Optional.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return collection.isEmpty
        case nil:
            return true
        }
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }
}

extension Optional where Wrapped == Int {
    var isNilOrZero: Bool {
        switch self {
        case let int?:
            return int == 0
        case nil:
            return true
        }
    }
}
