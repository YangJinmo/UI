//
//  SettingViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import UIKit

final class SettingViewController: BaseNavigationViewController {
    // MARK: - Views

    private lazy var presentButton = UIButton("Present", .title)

    // MARK: - View Life Cycle

    override convenience init() {
        self.init(title: "설정")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(presentButton, heightConstant: 44, center: view)

        presentButton.addTarget(self, action: #selector(presentButtonTouched(_:)), for: .touchUpInside)

        navigationView.addDismissButton(dismissButtonTouched)
    }

    @objc private func presentButtonTouched(_ sender: Any) {
        presentWithNavigationController(ReviewWriteViewController())
    }

    @objc private func dismissButtonTouched() {
        dismiss()
    }
}
