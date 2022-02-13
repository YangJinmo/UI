//
//  BottomSheetViewController.swift
//  UI
//
//  Created by Jmy on 2022/02/13.
//

import UIKit

class BottomSheetViewController: UIViewController {
    // MARK: - Properties

    private var contentViewHeight: CGFloat = 300
    private var contentViewTopConstraint: NSLayoutConstraint!

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

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

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

        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        let contentViewTopConstant = safeAreaHeight + bottomPadding
        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: contentViewTopConstant)

        Constraint.activate([
            contentViewTopConstraint,
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        backgroundView.addTapGestureRecognizer(self, action: #selector(backgroundViewTouched(_:)))
    }

    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom

        contentViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - contentViewHeight

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }

    private func hideBottomSheetAndDismiss() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom

        contentViewTopConstraint.constant = safeAreaHeight + bottomPadding

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.backgroundView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false)
            }
        }
    }

    @objc private func backgroundViewTouched(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndDismiss()
    }
}
