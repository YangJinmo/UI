//
//  SettingViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import UIKit

final class SettingViewController: BaseNavigationViewController {
    // MARK: - Constants

    private let vcName: String = "설정"

    // MARK: - Views

    private let presentButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(subview: presentButton, heightConstant: 44, center: view)

        presentButton.addTarget(self, action: #selector(presentButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func presentButtonTouched(_ sender: Any) {
        presentWithNavigationController(ReviewWriteViewController())
    }
}
