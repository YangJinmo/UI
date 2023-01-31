//
//  TimeInterval.swift
//  UI
//
//  Created by Jmy on 2022/06/04.
//

import Foundation.NSDate

extension TimeInterval {
    var milliseconds: Int64 {
        return Int64(self * 1000)
    }

    var seconds: Int64 {
        return Int64(rounded())
    }
}
