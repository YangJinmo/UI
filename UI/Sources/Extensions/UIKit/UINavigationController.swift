//
//  UINavigationController.swift
//  UI
//
//  Created by Jmy on 2022/01/31.
//

import UIKit.UINavigationController

extension UINavigationController {
    convenience init(rootViewController: UIViewController, tabBarItem: UITabBarItem) {
        self.init(rootViewController: rootViewController)

        isNavigationBarHidden = true
        title = tabBarItem.title
        self.tabBarItem = tabBarItem
    }

    func push(controller: UIViewController, animated: Bool = true) {
        pushViewController(controller, animated: animated)
    }

    @discardableResult
    func pop(animated: Bool = true) -> UIViewController? {
        return popViewController(animated: animated)
    }

    @discardableResult
    public func replace(with controller: UIViewController, animated: Bool = true) -> UIViewController? {
        var controllers = viewControllers
        let current = controllers.popLast()
        controllers.append(controller)

        setViewControllers(controllers, animated: animated)

        return current
    }

    @discardableResult
    public func replaceAll(with controller: UIViewController, animated: Bool = true) -> [UIViewController] {
        let currentControllers = viewControllers

        setViewControllers([controller], animated: animated)

        return currentControllers
    }
}
