//
//  ReviewViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewViewController: BaseTabViewController {
    // MARK: - Views

    private lazy var presentButton = UIButton("Present", .title)

    // MARK: - View Life Cycle

    override convenience init() {
        self.init(title: "리뷰")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
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
