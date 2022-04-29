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

        addObservers()
    }

    // MARK: - Methods

    private func setupTabBar() {
//        tabBar.tintColor = Color.tabBarTintColor
//        tabBar.backgroundColor = Color.tabBarBackgroundColor

//        let topBorder = CALayer()
//        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 1)
//        topBorder.backgroundColor = Color.topBorderBackgroundColor
//
//        tabBar.layer.addSublayer(topBorder)
//        tabBar.clipsToBounds = true

        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = Color.tabBarBackgroundColor
        tabBar.tintColor = Color.tabBarTintColor
        tabBar.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        tabBar.setShadow(x: 0, y: -2, blur: 2, alpha: 0.07)
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

        delegate = self
    }

    private func addObservers() {
        [
            // out
            (UIScene.willDeactivateNotification, #selector(willDeactivate)),
            (UIApplication.willResignActiveNotification, #selector(willResignActive)),

            // in
            (UIScene.willEnterForegroundNotification, #selector(willEnterForeground)),
            (UIScene.didActivateNotification, #selector(didActivate)),
            (UIApplication.didBecomeActiveNotification, #selector(didBecomeActive)),
        ]
        .forEach {
            NotificationCenter.default.addObserver(self, selector: $0.1, name: $0.0, object: nil)
        }
    }

    @objc private func willDeactivate(_ notification: Notification) {
        notification.name.rawValue.description.log()
    }

    @objc private func willResignActive(_ notification: Notification) {
        notification.name.rawValue.description.log()
    }

    @objc private func willEnterForeground(_ notification: Notification) {
        notification.name.rawValue.description.log()
    }

    @objc private func didActivate(_ notification: Notification) {
        notification.name.rawValue.description.log()
    }

    @objc private func didBecomeActive(_ notification: Notification) {
        notification.name.rawValue.description.log()
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return false
        }

        selectIndex.description.log("Tab: \(tabBarController.selectedIndex) to ")

        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.selectedIndex.description.log()
    }
}
