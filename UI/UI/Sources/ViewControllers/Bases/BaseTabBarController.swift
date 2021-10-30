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
        static let houseFill: UIImage? = UIImage(systemName: "house.fill") // 􀎟
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .systemBackground
        setupViewControllers()
    }
    
    // MARK: - Methods
    
    private func setupViewControllers() {
        let vc1 = TableViewController()
        let vc2 = CollectionViewController()
        let vc3 = ScrollViewController()
        let vc4 = TableViewController()
        let vc5 = TableViewController()
        
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
        nc2.title = "Home"
        nc3.title = "Home"
        nc4.title = "Home"
        nc5.title = "Home"
        
        nc1.tabBarItem.image = Image.house
        nc2.tabBarItem.image = Image.houseFill
        nc3.tabBarItem.image = Image.house
        nc4.tabBarItem.image = Image.houseFill
        nc5.tabBarItem.image = Image.house
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 1)
        topBorder.backgroundColor = UIColor.secondarySystemBackground.cgColor

        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
        viewControllers = [nc1, nc2, nc3, nc4, nc5]
    }
}
