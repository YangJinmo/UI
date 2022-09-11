//
//  UIApplication.swift
//  UI
//
//  Created by Jmy on 2022/03/23.
//

import UIKit.UIApplication

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

    class func getMostTopViewController(base: UIViewController? = nil) -> UIViewController? {
        var baseVC: UIViewController?

        if base != nil {
            baseVC = base
        } else {
            if #available(iOS 13, *) {
                baseVC = (UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first { $0.isKeyWindow })?.rootViewController
            } else {
                baseVC = UIApplication.shared.keyWindow?.rootViewController
            }
        }

        if let naviController = baseVC as? UINavigationController {
            return getMostTopViewController(base: naviController.visibleViewController)

        } else if let tabbarController = baseVC as? UITabBarController, let selected = tabbarController.selectedViewController {
            return getMostTopViewController(base: selected)

        } else if let presented = baseVC?.presentedViewController {
            return getMostTopViewController(base: presented)
        }
        return baseVC
    }
}
