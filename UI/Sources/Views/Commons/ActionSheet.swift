//
//  ActionSheet.swift
//  UI
//
//  Created by Jmy on 2022/07/01.
//

import UIKit

final class ActionSheet {
    static let shared = ActionSheet()

    var confirmButtonTouch: (() -> Void)?

    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.roundCorners(radius: 16)
        view.setShadow(x: 0, y: 0, blur: 8, alpha: 0.5)
        view.alpha = 0
        return view
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "원하는 후기를 못 찾으셨나요?"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.lineSpacing(.center)
        return titleLabel
    }()

    private let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "그렇다면 HOOGi에게 물어봐 주세요!"
        messageLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.lineSpacing(.center)
        return messageLabel
    }()

    private lazy var confirmButton = SelectableButton("HOOGi에게 물어보기!", isSelected: true).then {
        $0.heightWithSmallCornerRadius = 46
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.addTarget(self, action: #selector(confirmButtonTouched), for: .touchUpInside)
    }

    private lazy var dismissButton = UIButton().then {
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(.secondaryLabel, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.addTarget(self, action: #selector(dismissButtonTouched), for: .touchUpInside)
    }

    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    func show() {
        guard let keyWindow = UIWindow.key else {
            return
        }

        stackView.addArrangedSubviews(
            [
                titleLabel,
                messageLabel,
            ]
        )

        view.addSubviews(
            stackView,
            confirmButton,
            dismissButton
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -16),
        ])

        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor),
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 56),
            dismissButton.heightAnchor.constraint(equalToConstant: 44),
        ])

        keyWindow.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: keyWindow.leftAnchor, constant: 32),
            view.rightAnchor.constraint(equalTo: keyWindow.rightAnchor, constant: -32),
            view.bottomAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])

        view.openAnimatePopup()
    }

    func dismiss() {
        view.closeAnimatePopup {
            self.view.removeFromSuperview()
        }
    }

    @objc private func confirmButtonTouched() {
        confirmButtonTouch?()
        dismissButtonTouched()
    }

    @objc private func dismissButtonTouched() {
        dismiss()
    }
}
