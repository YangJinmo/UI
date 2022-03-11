//
//  BaseNavigationViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import UIKit

class BaseNavigationViewController: BaseTabViewController {
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationView.addPopButton(popButtonTouched)
    }

    // MARK: - Methods

    @objc private func popButtonTouched() {
        popViewController()
    }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
