//
//  UIColor.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit

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
