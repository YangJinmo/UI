//
//  Int.swift
//  UI
//
//  Created by JMY on 2022/02/10.
//

import CoreGraphics
import Foundation.NSDecimalNumber

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }

    var radiansToDegrees: CGFloat {
        return CGFloat(self) * 180 / .pi
    }

    func timeFormatted() -> String {
        let minutes: Int = (self / 60) % 60
        let seconds: Int = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var abbreviatedNumber: String {
        if self >= 1000000 {
            return "\((Double(self) / 1000000).floorNumber())M"
        }
        if self >= 1000 {
            return "\((Double(self) / 1000).floorNumber())K"
        }
        return String(self)
    }

    /// returns number of digits in Int number
    public var digitCount: Int {
        return numberOfDigits(in: self)
    }

    /// returns number of useful digits in Int number
    public var usefulDigitCount: Int {
        var count = 0
        for digitOrder in 0 ..< digitCount {
            /// get each order digit from self
            let digit = self % Int(truncating: pow(10, digitOrder + 1) as NSDecimalNumber)
                / Int(truncating: pow(10, digitOrder) as NSDecimalNumber)
            if isUseful(digit) { count += 1 }
        }
        return count
    }

    // private recursive method for counting digits
    private func numberOfDigits(in number: Int) -> Int {
        if number < 10 && number >= 0 || number > -10 && number < 0 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number / 10)
        }
    }

    // returns true if digit is useful in respect to self
    private func isUseful(_ digit: Int) -> Bool {
        return (digit != 0) && (self % digit == 0)
    }
}
