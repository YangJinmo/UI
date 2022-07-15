//
//  ReviewWriteViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewWriteViewController: BaseTabViewController {
    // MARK: - Views

    private lazy var pushButton = UIButton("Push", .title)

    // MARK: - View Life Cycle

    override convenience init() {
        self.init(title: "리뷰 작성")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(pushButton, heightConstant: 44, center: view)

        pushButton.addTarget(self, action: #selector(pushButtonTouched(_:)), for: .touchUpInside)

        addDismissButton()
    }

    @objc private func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
