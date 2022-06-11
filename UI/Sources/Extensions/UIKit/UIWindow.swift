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
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .filter({ $0.isKeyWindow }).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
