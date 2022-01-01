//
//  BaseViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Constants

    private enum Image {
        static let chevronLeft: UIImage? = UIImage(systemName: "chevron.left")
    }

    private enum Font {
        static let titleLabel: UIFont = .systemFont(ofSize: 18, weight: .bold)
        static let rightButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    }

    private enum Color {
        static let leftButtonTint: UIColor = .label
        static let rightButtonTitle: UIColor = .label
    }

    // MARK: - Views

    let titleView: UIView = UIView()

    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = Font.titleLabel
        label.textAlignment = .center
        return label
    }()

    let popButton: UIButton = {
        let button: UIButton = UIButton()
        button.isHidden = true
        button.setImage(Image.chevronLeft, for: .normal)
        button.tintColor = Color.leftButtonTint
        return button
    }()

    let dismissButton: UIButton = {
        let button: UIButton = UIButton()
        button.isHidden = true
        button.setTitle("확인", for: .normal)
        button.setTitleColor(Color.rightButtonTitle, for: .normal)
        button.titleLabel?.font = Font.rightButton
        return button
    }()

    private let dividerView = DividerView()
    let contentView = UIView()
    private let scrollView = UIScrollView()
    private let guideView = UIView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubviews(
            titleView,
            popButton,
            dismissButton,
            titleLabel,
            dividerView,
            contentView
        )

        Constraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 44),

            popButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            popButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            popButton.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            popButton.widthAnchor.constraint(equalToConstant: 56),

            dismissButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            dismissButton.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 56),

            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: popButton.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: dismissButton.leftAnchor),

            dividerView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            dividerView.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: titleView.rightAnchor),

            contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }

    func hideDivider() {
        dividerView.isHidden = true
    }

    func setupScrollableStackView(_ views: UIView..., margin: CGFloat = 0) {
        view.addSubviews(scrollView)
        scrollView.addSubviews(guideView)
        guideView.addSubviews(stackView)
        views.forEach { stackView.addArrangedSubview($0) }

        let guideViewHeightConstraint = guideView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        guideViewHeightConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            guideView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            guideView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            guideView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            guideView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            guideView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: guideView.topAnchor, constant: margin),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: guideView.bottomAnchor, constant: -margin),
            stackView.leadingAnchor.constraint(equalTo: guideView.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: guideView.trailingAnchor, constant: -margin),
            stackView.centerYAnchor.constraint(equalTo: guideView.centerYAnchor),

            guideViewHeightConstraint,
        ])
    }
}
