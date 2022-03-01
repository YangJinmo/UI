//
//  BaseTabViewController.swift
//  UI
//
//  Created by JMY on 2022/02/22.
//

import UIKit

class BaseTabViewController: BaseViewController {
    // MARK: - Properties

    override var title: String? {
        didSet {
            setTitleLabel(title)
        }
    }

    private enum Image {
        static let chevronLeft = UIImage(systemName: "chevron.left")
        static let xmark = UIImage(systemName: "xmark")
    }

    private enum Height {
        static let navigationController: CGFloat = 56.0
    }

    // MARK: - Views

    lazy var titleView = UIView()

    lazy var titleLabel: UILabel = {
        let label = UILabel.makeForTitle()
        label.textAlignment = .center
        return label
    }()

    lazy var popButton: UIButton = {
        let button = UIButton(Image.chevronLeft)
        button.isHidden = true
        return button
    }()

    lazy var dismissButton: UIButton = {
        let button = UIButton(Image.xmark)
        button.isHidden = true
        return button
    }()

    lazy var contentView = UIView()
    private lazy var scrollView = UIScrollView()
    private lazy var guideView = UIView()
    private lazy var stackView: UIStackView = {
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
            contentView,
            titleView
        )

        Constraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            titleView.heightAnchor.constraint(equalToConstant: Height.navigationController),

            contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])

        titleView.addSubviews(
            popButton,
            dismissButton,
            titleLabel
        )

        Constraint.activate([
            popButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            popButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            popButton.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            popButton.widthAnchor.constraint(equalToConstant: Height.navigationController),

            dismissButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            dismissButton.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: Height.navigationController),

            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: popButton.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: dismissButton.leftAnchor),
        ])
    }

    func setTitleLabel(_ text: String?) {
        titleLabel.text = text

        titleView.backgroundColor = .systemBackground
        titleView.setBottomShadow()
    }

    func setupScrollableStackView(_ views: UIView..., margin: CGFloat = 0.0) {
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
