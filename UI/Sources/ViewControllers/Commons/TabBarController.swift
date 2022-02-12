//
//  TabBarController.swift
//  UI
//
//  Created by Jmy on 2021/10/29.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Constants

    private enum Image {
        static let house = UIImage(systemName: "house")
        static let magnifyingglass = UIImage(systemName: "magnifyingglass")
        static let bag = UIImage(systemName: "bag")
        static let message = UIImage(systemName: "message")
        static let person = UIImage(systemName: "person")
    }

    private enum Color {
        static let viewBackgroundColor = UIColor.systemBackground
        static let tabBarTintColor = UIColor.label
        static let tabBarBackgroundColor = UIColor.systemBackground
        static let topBorderBackgroundColor = UIColor.secondarySystemBackground.cgColor
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.viewBackgroundColor

        setupTabBar()
        setupViewControllers()
    }

    // MARK: - Methods

    private func setupTabBar() {
        tabBar.tintColor = Color.tabBarTintColor
        tabBar.backgroundColor = Color.tabBarBackgroundColor

        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 1)
        topBorder.backgroundColor = Color.topBorderBackgroundColor

        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }

    private func setupViewControllers() {
        viewControllers = [
            UINavigationController(
                rootViewController: TableViewController(),
                tabBarItem: UITabBarItem(
                    title: "Home",
                    image: Image.house,
                    selectedImage: Image.house
                )
            ),
            UINavigationController(
                rootViewController: TimerViewController(),
                tabBarItem: UITabBarItem(
                    title: "Search",
                    image: Image.magnifyingglass,
                    selectedImage: Image.magnifyingglass
                )
            ),
            UINavigationController(
                rootViewController: ScrollableStackViewController(),
                tabBarItem: UITabBarItem(
                    title: "Basket",
                    image: Image.bag,
                    selectedImage: Image.bag
                )
            ),
            UINavigationController(
                rootViewController: ReviewViewController(),
                tabBarItem: UITabBarItem(
                    title: "Review",
                    image: Image.message,
                    selectedImage: Image.message
                )
            ),
            UINavigationController(
                rootViewController: MyViewController(),
                tabBarItem: UITabBarItem(
                    title: "My",
                    image: Image.person,
                    selectedImage: Image.person
                )
            ),
        ]
    }
}
