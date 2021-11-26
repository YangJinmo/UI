//
//  ReviewViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewViewController: BaseViewController {
    // MARK: - Views

    let presentButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    // MARK: - Constants

    private let vcName: String = "리뷰"

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
        // present(ReviewWriteViewController())
        presentWithNavigationController(ReviewWriteViewController())
    }
}
