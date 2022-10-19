//
//  UIApplication.swift
//  UI
//
//  Created by Jmy on 2022/03/23.
//

import UIKit.UIApplication

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

    // MARK: - Delegate

    class func topViewController(controller: UIViewController? = UIApplication.mainKeyWindow?.rootViewController) -> UIViewController? {
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
        let baseVC = base ?? mainKeyWindow?.rootViewController

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
