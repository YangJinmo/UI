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

        navigationView.addDismissButton(dismissButtonTouched)
    }

    // MARK: - Methods

    @objc private func dismissButtonTouched() {
        dismiss()
    }
}
