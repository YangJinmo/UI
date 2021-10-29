//
//  UINavigationController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import UIKit

extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, hidesBottomBarWhenPushed: Bool = true) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        pushViewController(viewController, animated: animated)
    }
    
    // MARK: - UICollectionViewCell
    
    func pushToViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
