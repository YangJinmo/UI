//
//  ReviewViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewViewController: BaseViewController {
    // MARK: - Constants

    private let vcName = "리뷰"

    // MARK: - Views

    private lazy var presentButton = UIButton("Present", .title)

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(presentButton, heightConstant: 44, center: view)

        presentButton.addTarget(self, action: #selector(presentButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func presentButtonTouched(_ sender: Any) {
        presentWithNavigationController(ReviewWriteViewController())
    }
}