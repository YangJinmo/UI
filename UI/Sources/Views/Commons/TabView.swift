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

    private var titleText = ""

    // MARK: - Initialization

    convenience init(titleText: String) {
        self.init()

        titleLabel.text = titleText
    }

    // MARK: - Views

    private lazy var titleView: UIView = UIView()
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeForTitle()
        label.textAlignment = .center
        return label
    }()

    private lazy var popButton: UIButton = {
        let button = UIButton(Image.chevronLeft)
        button.isHidden = true
        return button
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton("확인")
        button.isHidden = true
        return button
    }()

    private lazy var dividerView = DividerView()
    private lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    private lazy var guideView = UIView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
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
