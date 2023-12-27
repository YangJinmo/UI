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

    var milliseconds: Int {
        return Int(truncatingRemainder(dividingBy: 1) * 1000)
    }

    var seconds: Int {
        return Int(self) % 60
    }

    var minutes: Int {
        return (Int(self) / 60) % 60
    }

    var hours: Int {
        return Int(self) / 3600
    }
}
