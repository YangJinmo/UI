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
    // MARK: - UIWindow

    static var mainKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    static var sceneWindow: UIWindow? {
        guard let sceneDelegate = UIApplication.sceneDelegate else {
            Log.info("could not get scene delegate ")
            return nil
        }

        return sceneDelegate.window
    }

//    static var appWindow: UIWindow? {
//        guard let appDelegate = UIApplication.appDelegate else {
//            Log.info("could not get app delegate ")
//        }
//
//        return appDelegate.window
//    }

    // MARK: - Delegate

    static var sceneDelegate: SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
