//
//  UIViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

extension UIViewController {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool = true) {
        present(viewControllerToPresent, animated: flag, completion: nil)
    }
    
    func dismiss(animated flag: Bool = true) {
        dismiss(animated: flag, completion: nil)
    }
    
    // MARK: - UINavigationController
    
    func presentWithNavigationController(_ rootViewController: UIViewController, animated: Bool = true) {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: animated)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, hidesBottomBarWhenPushed: Bool = true) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.popToViewController(viewController, animated: animated)
    }
    
    func popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
