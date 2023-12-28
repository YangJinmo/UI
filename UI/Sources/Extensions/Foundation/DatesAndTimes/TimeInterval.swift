//
//  TimeInterval.swift
//  UI
//
//  Created by Jmy on 2022/06/04.
//

import Foundation.NSDate

extension TimeInterval {
    // 1,703,759,397.666739
    static var unixTime: TimeInterval {
        return Date().timeIntervalSince1970
    }

    // 1,703,759,398
    static var roundedUnixTime: TimeInterval {
        return Date().timeIntervalSince1970.rounded()
    }

    // 2023.12.28 19:51:21:105000
    var toDate: Date {
        return Date(timeIntervalSince1970: self)
    }

    // 105
    var milliseconds: Int {
        return Int(truncatingRemainder(dividingBy: 1) * 1000)
    }

    // 21
    var seconds: Int {
        return Int(self) % 60
    }

    // 51
    var minutes: Int {
        return (Int(self) / 60) % 60
    }

    // 473,266
    var hours: Int {
        return Int(self) / 3600
    }
}
