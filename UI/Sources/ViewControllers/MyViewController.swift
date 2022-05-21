//
//  MyViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class MyViewController: BaseTabViewController {
    // MARK: - Constants

    private enum Image {
        static let pencil = UIImage(systemName: "pencil")
    }

    private enum Font {
        static let nicknameButton = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    // MARK: - Views

    private lazy var emailButton = UIButton("Email")
    private lazy var alertButton = UIButton("Alert")
    private lazy var alertOptionButton = UIButton("AlertOption")
    private lazy var actionSheetButton = UIButton("ActionSheet")
    private lazy var searchButton = UIButton("Search")
    private lazy var delegateButton = UIButton("Delegate")
    private lazy var bottomSheetButton = UIButton("BottomSheet")
    private lazy var pushMessageButton = UIButton("PushMessage")
    private lazy var nicknameButton: UIButton = {
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
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.sizeToFit()
        return button
    }()

    // MARK: - View Life Cycle

    override convenience init() {
        self.init(title: "마이")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(
            emailButton,
            top: contentView.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            alertButton,
            top: emailButton.bottomAnchor,
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
            searchButton,
            top: actionSheetButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            delegateButton,
            top: searchButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 44
        )

        view.add(
            bottomSheetButton,
            top: delegateButton.bottomAnchor,
            left: view.leftAnchor, 44,
            right: view.rightAnchor, 44,
            heightConstant: 44
        )

        view.add(
            pushMessageButton,
            top: bottomSheetButton.bottomAnchor,
            left: view.leftAnchor, 44,
            right: view.rightAnchor, 44,
            heightConstant: 44
        )

        view.add(
            nicknameButton,
            bottom: contentView.safeAreaLayoutGuide.bottomAnchor, 20,
            heightConstant: 44,
            centerX: contentView
        )

        nicknameButton.addTarget(self, action: #selector(nicknameButtonTouched(_:)), for: .touchUpInside)

        emailButton.addTarget(self, action: #selector(mailButtonTouched(_:)), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(alertButtonTouched(_:)), for: .touchUpInside)
        alertOptionButton.addTarget(self, action: #selector(alertOptionButtonTouched(_:)), for: .touchUpInside)
        actionSheetButton.addTarget(self, action: #selector(actionSheetButtonTouched(_:)), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTouched(_:)), for: .touchUpInside)

        delegateButton.addTarget(self, action: #selector(delegateButtonTouched(_:)), for: .touchUpInside)
        bottomSheetButton.addTarget(self, action: #selector(bottomSheetButtonTouched(_:)), for: .touchUpInside)

        bottomSheetButton.backgroundColor = .red
        bottomSheetButton.layer.addBorder(color: .label, width: 1)
//        bottomSheetButton.layer.addBorder([.top, .left], color: .label, width: 2)
        bottomSheetButton.layer.setShadow(x: 2, y: 2, blur: 2, alpha: 1)

        pushMessageButton.addTarget(self, action: #selector(pushMessageButtonTouched(_:)), for: .touchUpInside)

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { _, _ in })
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
        // actionSheetImplementedInUIViewControllerExtension()
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

    @objc private func searchButtonTouched(_ sender: Any) {
        present(SearchViewController())
    }

    @objc private func delegateButtonTouched(_ sender: Any) {
        present(DelegateViewController(delegate: self))
    }

    @objc private func bottomSheetButtonTouched(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.setTitleLabel("정렬")
        vc.bind(selectedSort: selectedSort)
        vc.bind(didSelectItemAt: didSelectItemAt)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }

    @objc private func pushMessageButtonTouched(_ sender: Any) {
        "".log()
        let content = UNMutableNotificationContent()
        content.title = "This is title"
        content.subtitle = "This is Subtitle"
        content.body = "This is Body"
        content.badge = 1
    }

    private var selectedSort = Sort.dateOrder

    private func didSelectItemAt(selectedSort: Sort) {
        self.selectedSort = selectedSort
    }
}

extension MyViewController: ChangeUIDelegate {
    func changeUI() {
        contentView.backgroundColor = .random()

        toast("UI가 변경되었습니다.", bottom: true)
    }
}
