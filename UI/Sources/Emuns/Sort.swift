//
//  Sort.swift
//  UI
//
//  Created by JMY on 2022/03/08.
//

enum Sort: String, CaseIterable {
    case dateOrder
    case viewOrder

    var description: String {
        switch self {
        case .dateOrder: return "최신순"
        case .viewOrder: return "조회순"
        }
    }
}
