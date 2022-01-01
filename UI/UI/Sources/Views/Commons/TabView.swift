//
//  TabView.swift
//  UI
//
//  Created by Jmy on 2021/11/29.
//

import UIKit

class TabView: BaseView {
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

    private var titleText: String = ""

    // MARK: - Initialization

    convenience init(titleText: String) {
        self.init()

        titleLabel.text = titleText
    }

    // MARK: - Views

    private let titleView: UIView = UIView()

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = Font.titleLabel
        label.textAlignment = .center
        return label
    }()

    private let popButton: UIButton = {
        let button: UIButton = UIButton()
        button.isHidden = true
        button.setImage(Image.chevronLeft, for: .normal)
        button.tintColor = Color.leftButtonTint
        return button
    }()

    private let dismissButton: UIButton = {
        let button: UIButton = UIButton()
        button.isHidden = true
        button.setTitle("확인", for: .normal)
        button.setTitleColor(Color.rightButtonTitle, for: .normal)
        button.titleLabel?.font = Font.rightButton
        return button
    }()

    private let dividerView = DividerView()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let guideView = UIView()
    private let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - Layout Constraints

    private var bottomConstraint: Constraint? {
        didSet {
            if oldValue != nil {
                removeConstraint(oldValue!)
            }
            if bottomConstraint != nil {
                addConstraint(bottomConstraint!)
            }
        }
    }

    // MARK: - Methods

    override func setupViews() {
        backgroundColor = .systemBackground

        addSubviews(
            titleView,
            popButton,
            dismissButton,
            titleLabel,
            dividerView,
            contentView
        )

        Constraint.activate([
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
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
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }

    func setupScrollableStackView(_ views: UIView...) {
        contentView.addSubviews(scrollView)
        scrollView.addSubviews(stackView)
        views.forEach { stackView.addArrangedSubview($0) }

        bottomConstraint = Constraint(
            item: scrollView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )

        Constraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

    func setupScrollableStackView(_ views: UIView..., margin: CGFloat = 0) {
        contentView.addSubviews(scrollView)
        scrollView.addSubviews(guideView)
        guideView.addSubviews(stackView)
        views.forEach { stackView.addArrangedSubview($0) }

        bottomConstraint = Constraint(
            item: scrollView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )

        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow

        Constraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            guideView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            guideView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            guideView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            guideView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            guideView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: guideView.topAnchor, constant: margin),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: guideView.bottomAnchor, constant: -margin),
            stackView.leftAnchor.constraint(equalTo: guideView.leftAnchor, constant: margin),
            stackView.rightAnchor.constraint(equalTo: guideView.rightAnchor, constant: -margin),
            stackView.centerYAnchor.constraint(equalTo: guideView.centerYAnchor),

            contentViewHeightConstraint,
        ])
    }
}
