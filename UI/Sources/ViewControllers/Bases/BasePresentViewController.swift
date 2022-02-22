//
//  BasePresentViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import UIKit

class BasePresentViewController: BaseTabViewController {
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDismissButton()
    }

    // MARK: - Methods

    private func setupDismissButton() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTouched(_:)), for: .touchUpInside)
        dismissButton.isHidden = false
    }

    @objc private func dismissButtonTouched(_ sender: Any) {
        dismiss()
    }
}
