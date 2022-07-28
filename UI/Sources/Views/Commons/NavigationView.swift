//
//  NavigationView.swift
//  UI
//
//  Created by JMY on 2022/03/08.
//

import UIKit

final class NavigationView: BaseView {
    // MARK: - Properties

    private enum Image {
        static let chevronLeft = UIImage(systemName: "chevron.left")
        static let xmark = UIImage(systemName: "xmark")
    }

    private var popButtonTouch: CompletionHandler?
    private var dismissButtonTouch: CompletionHandler?

    // MARK: - Views

    private lazy var titleLabel = UILabel.title()
    private lazy var popButton: UIButton = {
        let button = UIButton(Image.chevronLeft)
        button.isHidden = true
        button.addTarget(self, action: #selector(popButtonTouched), for: .touchUpInside)
        return button
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton(Image.xmark)
        button.isHidden = true
        button.addTarget(self, action: #selector(dismissButtonTouched), for: .touchUpInside)
        return button
    }()

    // MARK: - View Life Cycle

    override func commonInit() {
        addSubviews(
            popButton,
            dismissButton,
            titleLabel
        )

        Constraint.activate([
            popButton.topAnchor.constraint(equalTo: topAnchor),
            popButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            popButton.leftAnchor.constraint(equalTo: leftAnchor),
            popButton.widthAnchor.constraint(equalToConstant: navigationBarHeight),

            dismissButton.topAnchor.constraint(equalTo: topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            dismissButton.rightAnchor.constraint(equalTo: rightAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: navigationBarHeight),

            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: navigationBarHeight),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -navigationBarHeight),
        ])
    }

    // MARK: - Methods

    func setNavigationViewBottomShadow() {
        backgroundColor = .systemBackground
        setBottomShadow()
    }

    func setTitleLabel(_ text: String?) {
        titleLabel.text = text
    }

    func addPopButton(_ popButtonTouch: CompletionHandler?) {
        self.popButtonTouch = popButtonTouch

        popButton.isHidden = false
    }

    func addDismissButton(_ dismissButtonTouch: CompletionHandler?) {
        self.dismissButtonTouch = dismissButtonTouch

        dismissButton.isHidden = false
    }

    @objc private func popButtonTouched() {
        popButtonTouch?()
    }

    @objc private func dismissButtonTouched() {
        dismissButtonTouch?()
    }
}
