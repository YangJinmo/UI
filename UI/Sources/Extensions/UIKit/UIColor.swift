//
//  UIColor.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit.UIColor

extension UIColor {
//    let black = UIColor(r: 0x00, g: 0x00, b: 0x00, a: 0.5)
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")

        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: a
        )
    }

//    let white = UIColor(rgb: 0xFFFFFF, a: 0.5)
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            r: (rgb >> 16) & 0xFF,
            g: (rgb >> 8) & 0xFF,
            b: rgb & 0xFF,
            a: a
        )
    }

//    let tintColor = UIColor.rgb(r: 234, g: 57, b: 92)
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return .init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }

//    let backgroundColor = UIColor.white(241)
    static func white(_ w: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return .init(white: w / 255, alpha: a)
    }

//    let purple = UIColor.hex(0xAB47BC)
    static func hex(_ hex: Int, a: CGFloat = 1.0) -> UIColor {
        let color = (
            r: (hex >> 16) & 0xFF,
            g: (hex >> 08) & 0xFF,
            b: (hex >> 00) & 0xFF
        )

        "r: \(color.r), g: \(color.g), b: \(color.b), a: \(a)".log()

        return rgb(r: CGFloat(color.r), g: CGFloat(color.g), b: CGFloat(color.b), a: a)
    }

//    let randomColor = UIColor.random()
    static func random(a: CGFloat = 1.0) -> UIColor {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)

        "r: \(r), g: \(g), b: \(b), a: \(a)".log()

        return rgb(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: a)
    }

    var hexString: String {
        guard let components = cgColor.components else {
            return "000000"
        }

        let r = components[0]
        let g = components[1]
        let b = components[2]
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}

import CoreGraphics.CGColor

extension CGColor {
    static func hex(_ hex: Int, a: CGFloat = 1.0) -> CGColor {
        return UIColor.hex(hex, a: a).cgColor
    }

    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> CGColor {
        return UIColor.rgb(r: r, g: g, b: b, a: a).cgColor
    }

    static func white(_ w: CGFloat, a: CGFloat = 1.0) -> CGColor {
        return UIColor.white(w, a: a).cgColor
    }

    static func random(a: CGFloat = 1.0) -> CGColor {
        return UIColor.random(a: a).cgColor
    }
}
