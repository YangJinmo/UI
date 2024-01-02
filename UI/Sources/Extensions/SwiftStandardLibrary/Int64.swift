//
//  Int64.swift
//  UI
//
//  Created by Jmy on 2023/05/19.
//

import Foundation.NSDate

extension Int64 {
    var hours: Int64 {
        return self / 3600
    }

    var minutes: Int64 {
        return (self / 60) % 60
    }

    var seconds: Int64 {
        return self % 60
    }
}
