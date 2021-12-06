//
//  MyViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class MyViewController: BaseViewController {
    // MARK: - Constants
    
    private struct Image {
        static let pencil: UIImage? = UIImage(systemName: "pencil")
    }
    
    private struct Font {
        static let nicknameButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        static let settingButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let vcName: String = "마이"
    
    // MARK: - Views
    
    private let nicknameButton: UIButton = {
        var configuration: UIButton.Configuration = .filled()
        configuration.title = "Edit Nickname"
        configuration.subtitle = "닉네임 수정"
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        configuration.image = Image.pencil
        configuration.imagePlacement = .leading
        configuration.imagePadding = 16
        configuration.baseBackgroundColor = .systemIndigo
        configuration.baseForegroundColor = .systemPink
        let button: UIButton = UIButton(configuration: configuration, primaryAction: nil)
        button.sizeToFit()
        return button
    }()
    
    private let settingButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("설정", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.settingButton
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
        view.add(nicknameButton, heightConstant: 44, center: view, centerYConstant: -44)
        view.add(settingButton, heightConstant: 44, center: view)
        
        nicknameButton.addTarget(self, action: #selector(nicknameButtonTouched(_:)), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(pushButtonTouched(_:)), for: .touchUpInside)
    }
    
    @objc private func nicknameButtonTouched(_ sender: Any) {
        pushViewController(TextViewController())
    }

    @objc private func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
