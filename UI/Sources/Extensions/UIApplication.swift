//
//  UIApplication.swift
//  UI
//
//  Created by Jmy on 2022/03/23.
//

import UIKit

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
}
