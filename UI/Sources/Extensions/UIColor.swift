//
//  UIColor.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit.UIColor

extension UIColor {
    static let tint: UIColor = .systemOrange
    static let base: UIColor = .label

    static func random() -> UIColor {
        return UIColor(
            red: .random(),
            green: .random(),
            blue: .random(),
            alpha: 1.0
        )
    }
}

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return .init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }

    static func white(_ w: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return .init(white: w / 255, alpha: a)
    }
}

extension CGColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> CGColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a).cgColor
    }

    static func white(_ w: CGFloat, a: CGFloat = 1.0) -> CGColor {
        return UIColor(white: w / 255, alpha: a).cgColor
    }
}
