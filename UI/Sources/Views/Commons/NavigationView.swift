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

    private var popButtonTouch: voidHandler?
    private var dismissButtonTouch: voidHandler?

    // MARK: - Views

    private lazy var titleLabel = UILabel.title()
    private lazy var popButton = UIButton(Image.chevronLeft, isHidden: true)
    private lazy var dismissButton = UIButton(Image.xmark, isHidden: true)

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

    func addPopButton(_ popButtonTouch: voidHandler?) {
        self.popButtonTouch = popButtonTouch

        popButton.isHidden = false
        popButton.addTarget(self, action: #selector(popButtonTouched), for: .touchUpInside)
    }

    func addDismissButton(_ dismissButtonTouch: voidHandler?) {
        self.dismissButtonTouch = dismissButtonTouch

        dismissButton.isHidden = false
        dismissButton.addTarget(self, action: #selector(dismissButtonTouched), for: .touchUpInside)
    }

    @objc private func popButtonTouched() {
        popButtonTouch?()
    }

    @objc private func dismissButtonTouched() {
        dismissButtonTouch?()
    }
}
