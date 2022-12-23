//
//  UIEdgeInsets.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit.UIGeometry

extension UIEdgeInsets {
    init(_ top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    static func uniform(size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
}
