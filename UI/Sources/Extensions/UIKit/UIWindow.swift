//
//  UIWindow.swift
//  UI
//
//  Created by Jmy on 2021/12/10.
//

import UIKit.UIWindow

extension UIWindow {
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(rootViewController)
    }

    static func getVisibleViewControllerFrom(_ viewController: UIViewController?) -> UIViewController? {
        if let navController = viewController as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(navController.visibleViewController)

        } else if let tabBarController = viewController as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tabBarController.selectedViewController)

        } else if let presentedVC = viewController?.presentedViewController {
            return UIWindow.getVisibleViewControllerFrom(presentedVC)

        } else {
            return viewController
        }
    }
}
