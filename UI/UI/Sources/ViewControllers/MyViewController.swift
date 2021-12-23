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
        static let basicButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
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

    private let mailButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Email", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }()

    private let alertButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("alert", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }()

    private let alertOptionButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("alertOption", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }()

    private let actionSheetButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("actionSheet", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }()

    private let delegateButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("delegate", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
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
        view.add(
            nicknameButton,
            heightConstant: 44,
            center: view
        )

        view.add(
            mailButton,
            top: contentView.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            alertButton,
            top: mailButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            alertOptionButton,
            top: alertButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            actionSheetButton,
            top: alertOptionButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            delegateButton,
            top: actionSheetButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        nicknameButton.addTarget(self, action: #selector(nicknameButtonTouched(_:)), for: .touchUpInside)

        mailButton.addTarget(self, action: #selector(mailButtonTouched(_:)), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(alertButtonTouched(_:)), for: .touchUpInside)
        alertOptionButton.addTarget(self, action: #selector(alertOptionButtonTouched(_:)), for: .touchUpInside)
        actionSheetButton.addTarget(self, action: #selector(actionSheetButtonTouched(_:)), for: .touchUpInside)
        delegateButton.addTarget(self, action: #selector(delegateButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func nicknameButtonTouched(_ sender: Any) {
        pushViewController(TextViewController())
    }

    @objc private func mailButtonTouched(_ sender: Any) {
        pushViewController(MailComposeViewController())
    }

    @objc private func alertButtonTouched(_ sender: Any) {
        alert(
            title: "title",
            message: "message"
        ) { _ in
            "cancelHandler".log()
        } completion: {
            "completion".log()
        }
    }

    @objc private func alertOptionButtonTouched(_ sender: Any) {
        alertOption(
            title: "title",
            message: "message"
        ) { _ in
            "confirmHandler".log()
        } cancelHandler: { _ in
            "cancelHandler".log()
        } completion: {
            "completion".log()
        }
    }

    @objc private func actionSheetButtonTouched(_ sender: Any) {
        //actionSheetImplementedInUIViewControllerExtension()
        actionSheetImplementedInUIAlertControllerExtension()
    }

    private func actionSheetImplementedInUIViewControllerExtension() {
        actionSheet(
            title: "title",
            message: "message",
            actions:
            .default("default", { _ in
                "default".log()
            }),
            .destructive("destructive", { _ in
                "destructive".log()
            })
        ) { _ in
            "cancel".log()
        } completion: {
            "completion".log()
        }
    }

    private func actionSheetImplementedInUIAlertControllerExtension() {
        present(
            UIAlertController
                .actionSheet(title: "title", message: "message")
                .action(title: "default", style: .default) { _ in
                    "default".log()
                }
                .action(title: "destructive", style: .destructive) { _ in
                    "destructive".log()
                }
                .action(title: "취소", style: .cancel) { _ in
                    "cancel".log()
                }
        ) {
            "completion".log()
        }
    }

    @objc private func delegateButtonTouched(_ sender: Any) {
        present(DelegateViewController(delegate: self))
    }

    private func getRandomColor() -> UIColor {
        return UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 0.5
        )
    }
}

extension MyViewController: ChangeUIDelegate {
    func changeUI() {
        view.backgroundColor = getRandomColor()

        toast("UI가 변경되었습니다.", bottom: true)
    }
}
