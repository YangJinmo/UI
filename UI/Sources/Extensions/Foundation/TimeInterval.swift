//
//  TimeInterval.swift
//  UI
//
//  Created by Jmy on 2022/06/04.
//

import Vision

extension TimeInterval {
    var seconds: Int64 {
        return Int64(rounded())
    }

    var milliseconds: Int64 {
        return Int64(self * 1000)
    }
}
