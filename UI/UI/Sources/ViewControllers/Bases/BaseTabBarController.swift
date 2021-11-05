//
//  BaseTabBarController.swift
//  UI
//
//  Created by Jmy on 2021/10/29.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    // MARK: - Constants
    
    private struct Image {
        static let house: UIImage? = UIImage(systemName: "house") // 􀎞
        static let magnifyingglass: UIImage? = UIImage(systemName: "magnifyingglass") // 􀊫
        static let bag: UIImage? = UIImage(systemName: "bag") // 􀍣
        static let message: UIImage? = UIImage(systemName: "message") // 􀌤
        static let person: UIImage? = UIImage(systemName: "person") // 􀉩
    }
    
    private struct Color {
        static let viewBackgroundColor: UIColor = .systemBackground
        static let tabBarTintColor: UIColor = .label
        static let tabBarBackgroundColor: UIColor = .systemBackground
        static let topBorderBackgroundColor: CGColor = UIColor.secondarySystemBackground.cgColor
    }

    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = Color.viewBackgroundColor
        setupViewControllers()
    }
    
    // MARK: - Methods
    
    private func setupViewControllers() {
        let vc1 = TableViewController()
        let vc2 = CollectionViewController()
        let vc3 = ScrollViewController()
        let vc4 = ReviewViewController()
        let vc5 = MyViewController()
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)
        let nc4 = UINavigationController(rootViewController: vc4)
        let nc5 = UINavigationController(rootViewController: vc5)
        
        nc1.isNavigationBarHidden = true
        nc2.isNavigationBarHidden = true
        nc3.isNavigationBarHidden = true
        nc4.isNavigationBarHidden = true
        nc5.isNavigationBarHidden = true
        
        nc1.title = "Home"
        nc2.title = "Search"
        nc3.title = "Basket"
        nc4.title = "Review"
        nc5.title = "My"
        
        nc1.tabBarItem.image = Image.house
        nc2.tabBarItem.image = Image.magnifyingglass
        nc3.tabBarItem.image = Image.bag
        nc4.tabBarItem.image = Image.message
        nc5.tabBarItem.image = Image.person
        
        tabBar.tintColor = Color.tabBarTintColor
        tabBar.backgroundColor = Color.tabBarBackgroundColor
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 1)
        topBorder.backgroundColor = Color.topBorderBackgroundColor

        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
        viewControllers = [nc1, nc2, nc3, nc4, nc5]
    }
}
