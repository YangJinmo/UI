//
//  UIWindow.swift
//  UI
//
//  Created by Jmy on 2021/12/10.
//

import UIKit.UIWindow

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
