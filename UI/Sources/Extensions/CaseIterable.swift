//
//  CaseIterable.swift
//  UI
//
//  Created by JMY on 2022/05/16.
//

extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
