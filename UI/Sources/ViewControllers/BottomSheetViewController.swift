//
//  BottomSheetViewController.swift
//  UI
//
//  Created by Jmy on 2022/02/13.
//

import UIKit

class BottomSheetViewController: UIViewController {
    // MARK: - Properties

    private var contentViewHeight: CGFloat = 300.0
    private var contentViewTopConstraint: NSLayoutConstraint!
    private var contentViewTopConstraintConstant: CGFloat {
        return safeAreaHeight + safeAreaBottom
    }

    private var action: Closure?

    // MARK: - Views

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let rectCorner: UIRectCorner = [.topLeft, .topRight]
        view.layer.masksToBounds = false
        view.layer.maskedCorners = CACornerMask(rawValue: rectCorner.rawValue)
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var completeButton = RecommendedButton("완료", recommended: .main, isRecommended: false)

    // MARK: - View Life Cycle

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        showBottomSheet()
    }

    // MARK: - Methods

    private func setupViews() {
        view.addSubview(backgroundView)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        Constraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        view.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: contentViewTopConstraintConstant)

        Constraint.activate([
            contentViewTopConstraint,
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: contentViewHeight + safeAreaBottom),
        ])

        stackView.addArrangedSubview(completeButton)

        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        Constraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(safeAreaBottom + 20)),
        ])

        backgroundView.addTapGestureRecognizer(self, action: #selector(backgroundViewTouched(_:)))

        completeButton.addTarget(self, action: #selector(completeButtonTouched(_:)), for: .touchUpInside)
    }

    private func showBottomSheet() {
        contentViewTopConstraint.constant = contentViewTopConstraintConstant - contentViewHeight - safeAreaBottom

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }

    private func hideBottomSheetAndDismiss(completion: (() -> Void)? = nil) {
        contentViewTopConstraint.constant = contentViewTopConstraintConstant

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: completion)
            }
        }
    }

    @objc private func backgroundViewTouched(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndDismiss()
    }

    func bind(action: @escaping Closure) {
        self.action = action
    }

    @objc private func completeButtonTouched(_ sender: Any) {
        hideBottomSheetAndDismiss {
            guard let action = self.action else { return }
            action()
        }
    }
}
