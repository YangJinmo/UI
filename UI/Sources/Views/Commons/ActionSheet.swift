//
//  ActionSheet.swift
//  UI
//
//  Created by Jmy on 2022/07/01.
//

import UIKit

final class ActionSheet {
    static let shared = ActionSheet()

    var confirmButtonTouch: voidHandler?

    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.setShadow(x: 0, y: 0, blur: 8, alpha: 0.5)
        view.alpha = 0
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "원하는 결과를 못 찾으셨나요?"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.lineSpacing(.center)
        return titleLabel
    }()

    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "그렇다면 저희에게 물어봐 주세요!"
        messageLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        messageLabel.lineSpacing(.center)
        return messageLabel
    }()

    private lazy var confirmButton: SelectableButton = {
        let button = SelectableButton("물어보기!", isSelected: true)
        button.font = .systemFont(ofSize: 17, weight: .semibold)
        button.height = 46
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(confirmButtonTouched), for: .touchUpInside)
        return button
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        button.addTarget(self, action: #selector(dismissButtonTouched), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    func show() {
        guard let keyWindow = UIWindow.key else {
            return
        }

        stackView.addArrangedSubviews(
            titleLabel,
            messageLabel
        )

        view.addSubviews(
            stackView,
            confirmButton,
            dismissButton
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        Constraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -16),
        ])

        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        Constraint.activate([
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        Constraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor),
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 56),
            dismissButton.heightAnchor.constraint(equalToConstant: 44),
        ])

        keyWindow.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        Constraint.activate([
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
