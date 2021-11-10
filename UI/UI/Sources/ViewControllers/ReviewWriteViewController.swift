//
//  ReviewWriteViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewWriteViewController: BasePresentViewController {
    // MARK: - Views

    let pushButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    // MARK: - Properties

    private let vcName: String = "리뷰 작성"

    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()

        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.addSubviews(
            pushButton
        )

        view.subviewsTranslatesAutoresizingMaskIntoConstraintsFalse()

        NSLayoutConstraint.activate([
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pushButton.heightAnchor.constraint(equalToConstant: 45),
        ])

        pushButton.addTarget(self, action: #selector(pushButtonTouched(_:)), for: .touchUpInside)
    }

    @objc func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
