//
//  UIDevice.swift
//  UI
//
//  Created by JMY on 2022/04/21.
//

import UIKit.UIDevice

extension UIDevice {
    var hasNotch: Bool {
        guard let keyWindow = UIWindow.key else {
            return false
        }
        let bottom = keyWindow.safeAreaInsets.bottom
        return bottom > 0
    }
}
