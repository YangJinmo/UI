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
        setupPopButton()
    }

    // MARK: - Methods

    private func setupPopButton() {
        popButton.addTarget(self, action: #selector(popButtonTouched(_:)), for: .touchUpInside)
        popButton.isHidden = false
    }

    @objc private func popButtonTouched(_ sender: Any) {
        popViewController()
    }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
