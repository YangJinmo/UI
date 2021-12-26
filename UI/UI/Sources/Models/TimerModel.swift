//
//  TimerModel.swift
//  UI
//
//  Created by Jmy on 2021/12/27.
//

import Foundation

struct TimerModel {
    private var startTime: Date?
    private var offset: TimeInterval = 0

    var elapsed: TimeInterval {
        return self.elapsed(since: Date())
    }

    var isRunning = false {
        didSet {
            if isRunning {
                startTime = Date()
            } else {
                if startTime != nil {
                    offset = elapsed
                    startTime = nil
                }
            }
        }
    }

    func elapsed(since: Date) -> TimeInterval {
        var elapsed = offset

        if let startTime = self.startTime {
            elapsed += -startTime.timeIntervalSince(since)
        }
        return elapsed
    }
}
