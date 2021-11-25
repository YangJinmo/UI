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

    // MARK: - Constants

    private let vcName: String = "리뷰 작성"

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(subview: pushButton, heightConstant: 44, center: view)
        
        pushButton.addTarget(self, action: #selector(pushButtonTouched(_:)), for: .touchUpInside)
    }

    @objc func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
