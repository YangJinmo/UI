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
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UIApplication {
    static var keyWindowInConnectedScenes: UIWindow? {
        if #available(iOS 13, *) {
            return shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return shared.keyWindow
        }
    }
}
