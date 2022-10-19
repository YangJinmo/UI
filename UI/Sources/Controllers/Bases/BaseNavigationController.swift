//
//  BaseNavigationController.swift
//  UI
//
//  Created by Jmy on 2022/10/19.
//

import UIKit

class BaseNavigationController: UINavigationController {
    private var duringTransition = false
    private var disabledPopVCs: [UIViewController.Type] = [] // [CViewController.self]

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringTransition = true

        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        duringTransition = false
    }
}

// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard
            gestureRecognizer == interactivePopGestureRecognizer,
            let topVC = topViewController
        else {
            return true
        }

        return viewControllers.count > 1 && duringTransition == false && isPopGestureEnable(topVC)
    }

    private func isPopGestureEnable(_ topVC: UIViewController) -> Bool {
        for vc in disabledPopVCs {
            if String(describing: type(of: topVC)) == String(describing: vc) {
                return false
            }
        }
        return true
    }
}

/// https://yungsoyu.medium.com/swift-pop-gesture-swipe-back-gesture-%EB%A1%9C-%EB%92%A4%EB%A1%9C%EA%B0%80%EA%B8%B0-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-7cb2d8f9e814
