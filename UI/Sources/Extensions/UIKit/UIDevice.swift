//
//  UIDevice.swift
//  UI
//
//  Created by JMY on 2022/04/21.
//

import UIKit.UIDevice

extension UIDevice {
    var hasNotch: Bool {
        guard let keyWindow = UIApplication.mainKeyWindow else {
            return false
        }
        let bottom = keyWindow.safeAreaInsets.bottom
        return bottom > 0
    }

    static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
