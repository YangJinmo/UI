//
//  Int.swift
//  UI
//
//  Created by JMY on 2022/02/10.
//

import CoreGraphics

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }

    func timeFormatted() -> String {
        let minutes: Int = (self / 60) % 60
        let seconds: Int = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
