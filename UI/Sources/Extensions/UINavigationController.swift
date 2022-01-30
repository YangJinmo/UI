//
//  UINavigationController.swift
//  UI
//
//  Created by Jmy on 2022/01/31.
//

import UIKit

extension UINavigationController {
    convenience init(rootViewController: UIViewController, tabBarItem: UITabBarItem) {
        self.init(rootViewController: rootViewController)

        isNavigationBarHidden = true
        title = tabBarItem.title
        self.tabBarItem = tabBarItem
    }
}
