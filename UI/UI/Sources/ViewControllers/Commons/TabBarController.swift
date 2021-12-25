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
        static let house: UIImage? = UIImage(systemName: "house")
        static let magnifyingglass: UIImage? = UIImage(systemName: "magnifyingglass")
        static let bag: UIImage? = UIImage(systemName: "bag")
        static let message: UIImage? = UIImage(systemName: "message")
        static let person: UIImage? = UIImage(systemName: "person")
    }

    private enum Color {
        static let viewBackgroundColor: UIColor = .systemBackground
        static let tabBarTintColor: UIColor = .label
        static let tabBarBackgroundColor: UIColor = .systemBackground
        static let topBorderBackgroundColor: CGColor = UIColor.secondarySystemBackground.cgColor
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
            BaseNavigationController(
                rootViewController: TableViewController(),
                title: "Home",
                image: Image.house
            ),
            BaseNavigationController(
                rootViewController: CollectionViewController(),
                title: "Search",
                image: Image.magnifyingglass
            ),
            BaseNavigationController(
                rootViewController: ScrollableStackViewController(),
                title: "Basket",
                image: Image.bag
            ),
            BaseNavigationController(
                rootViewController: ReviewViewController(),
                title: "Review",
                image: Image.message
            ),
            BaseNavigationController(
                rootViewController: MyViewController(),
                title: "My",
                image: Image.person
            ),
        ]
    }
}
