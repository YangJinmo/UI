//
//  ReviewWriteViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewWriteViewController: BasePresentViewController {
    // MARK: - Constants

    private let vcName = "리뷰 작성"

    // MARK: - Views

    private lazy var pushButton = UIButton("Push", .title)

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(pushButton, heightConstant: 44, center: view)

        pushButton.addTarget(self, action: #selector(pushButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
