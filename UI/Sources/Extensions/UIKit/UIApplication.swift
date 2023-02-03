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

    // MARK: - Etcs

    class func topViewController(_ viewController: UIViewController? = mainKeyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let tabController = viewController as? UITabBarController, let selected = tabController.selectedViewController {
            return topViewController(selected)
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }

    func runInBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
}
