//
//  TimeInterval.swift
//  UI
//
//  Created by Jmy on 2022/06/04.
//

import Foundation.NSDate

extension TimeInterval {
    static var unixTime: TimeInterval {
        return Date().timeIntervalSince1970
    }

    var toDate: Date {
        return Date(timeIntervalSince1970: self)
    }
}
