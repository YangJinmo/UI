//
//  MyViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class MyViewController: BaseViewController {
    // MARK: - Views

    let pushButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    // MARK: - Constants

    private let vcName: String = "마이"

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

    @objc private func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
