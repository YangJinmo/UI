//
//  Collection.swift
//  UI
//
//  Created by JMY on 2022/02/11.
//

import Foundation

extension Collection {
    subscript(optional i: Index) -> Bool { indices.contains(i) }
    subscript(optional i: Index) -> Iterator.Element? { indices.contains(i) ? self[i] : nil }
}
