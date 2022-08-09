//
//  Color.swift
//  UI
//
//  Created by Jmy on 2022/08/09.
//

import UIKit.UIColor

extension UIColor {
    static let tint = UIColor.systemOrange
    static let base = UIColor.label
}

extension CGColor {
    static let tint = UIColor.tint.cgColor
    static let base = UIColor.base.cgColor
}
