//
//  BaseNavigationViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import UIKit

class BaseNavigationViewController: BaseViewController {
    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()

        setupPopButton()
    }

    // MARK: - Methods

    func setupPopButton() {
        popButton.addTarget(self, action: #selector(popButtonTouched(_:)), for: .touchUpInside)
        popButton.isHidden = false
    }

    @objc func popButtonTouched(_ sender: Any) {
        popViewController()
    }
}
