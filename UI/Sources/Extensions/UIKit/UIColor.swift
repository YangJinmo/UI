//
//  UIColor.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit.UIColor

extension UIColor {
//    let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, a: 0.5)
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

//    let color = UIColor(rgb: 0xFFFFFF, a: 0.5)
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }

    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return .init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }

    static func white(_ w: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return .init(white: w / 255, alpha: a)
    }

    static func random(a: CGFloat = 1.0) -> UIColor {
        let r = CGFloat.random(in: 0 ... 1)
        let g = CGFloat.random(in: 0 ... 1)
        let b = CGFloat.random(in: 0 ... 1)
        "".log("r: \(r), g: \(g), b: \(b), a: \(a)")
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

    static func random2(a: CGFloat = 1.0) -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        "".log("r: \(r), g: \(g), b: \(b), a: \(a)")
        return rgb(r: r, g: g, b: b, a: a)
    }
}

extension CGColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> CGColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a).cgColor
    }

    static func white(_ w: CGFloat, a: CGFloat = 1.0) -> CGColor {
        return UIColor(white: w / 255, alpha: a).cgColor
    }

    static func random(a: CGFloat = 1.0) -> CGColor {
        let r = CGFloat.random(in: 0 ... 1)
        let g = CGFloat.random(in: 0 ... 1)
        let b = CGFloat.random(in: 0 ... 1)
        "".log("r: \(r), g: \(g), b: \(b), a: \(a)")
        return CGColor(red: r, green: g, blue: b, alpha: 1.0)
    }

    static func random2(a: CGFloat = 1.0) -> CGColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        "".log("r: \(r), g: \(g), b: \(b), a: \(a)")
        return rgb(r: r, g: g, b: b, a: a)
    }
}
