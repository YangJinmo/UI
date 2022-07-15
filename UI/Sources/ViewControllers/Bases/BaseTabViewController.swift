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

    // MARK: - Views

    lazy var navigationView = NavigationView()
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
            navigationView
        )

        Constraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            navigationView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: navigationBarHeight),

            contentView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    // MARK: - Navigation View

    func setTitleLabel(_ text: String?) {
        navigationView.setNavigationViewBottomShadow()
        navigationView.setTitleLabel(text)
    }

    func addPopButton() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationView.addPopButton(popButtonTouched)
    }

    func addDismissButton() {
        navigationView.addDismissButton(dismissButtonTouched)
    }

    @objc private func popButtonTouched() {
        popViewController()
    }

    @objc private func dismissButtonTouched() {
        dismiss()
    }

    // MARK: - Scrollable Stack View

    func setupScrollableStackView(_ views: UIView..., margin: CGFloat = 0) {
        view.addSubviews(scrollView)
        scrollView.addSubviews(guideView)
        guideView.addSubviews(stackView)
        views.forEach { stackView.addArrangedSubview($0) }

        let guideViewHeightConstraint = guideView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        guideViewHeightConstraint.priority = .defaultLow

        Constraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
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

// MARK: - UIGestureRecognizerDelegate

extension BaseTabViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
