//
//  Int64.swift
//  UI
//
//  Created by Jmy on 2023/05/19.
//

import Foundation.NSDate

extension Int64 {
    static var timestamp: Int64 {
        return Date().millisecondsSince1970
    }

    var toDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self) / 1000)
    }
}
