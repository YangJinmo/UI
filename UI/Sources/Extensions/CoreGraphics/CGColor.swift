//
//  CGColor.swift
//  UI
//
//  Created by Jmy on 2023/03/21.
//

import CoreGraphics.CGColor

extension CGColor {
    static func hex(_ hex: UInt32, alpha: CGFloat = 1) -> CGColor {
        let color = (
            red: (hex >> 16) & 0xFF,
            green: (hex >> 08) & 0xFF,
            blue: (hex >> 00) & 0xFF
        )

        "red: \(color.red), green: \(color.green), blue: \(color.blue), alpha: \(alpha)".log()

        return .init(
            red: CGFloat(color.red) / 255,
            green: CGFloat(color.green) / 255,
            blue: CGFloat(color.blue) / 255,
            alpha: alpha
        )
    }

    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> CGColor {
        .init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }

    static func white(_ gray: CGFloat, alpha: CGFloat = 1.0) -> CGColor {
        .init(gray: gray, alpha: alpha)
    }

    static func random(alpha: CGFloat = 1.0) -> CGColor {
        let red = arc4random_uniform(256) // 0 ~ 255
        let green = arc4random_uniform(256)
        let blue = arc4random_uniform(256)

        "red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)".log()

        return .init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}
