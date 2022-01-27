//
//  UIEdgeInsets.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

extension UIEdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    static func uniform(size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
}
