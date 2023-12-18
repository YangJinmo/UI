//
//  Int64.swift
//  UI
//
//  Created by Jmy on 2023/05/19.
//

import Foundation.NSDate

extension Int64 {
    var millisecondsToSeconds: Int64 {
        return self / 1000
    }

    var seconds: Int64 {
        return self % 60
    }

    var millisecondsToTimeString: String {
        let seconds = millisecondsToSeconds

        if seconds >= 60 {
            var timeString = ""

            timeString += "\(seconds / 60)분"

            if seconds % 60 > 0 {
                timeString += " \(seconds % 60)초"
            }

            return timeString
        } else {
            return "\(seconds)초"
        }
    }
}
