//
//  BaseViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Constants

    private struct Image {
        static let chevronLeft: UIImage? = UIImage(systemName: "chevron.left")
    }

    private struct Font {
        static let titleLabel: UIFont = .systemFont(ofSize: 18, weight: .bold)
        static let rightButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    }

    private struct Color {
        static let leftButtonTint: UIColor = UIColor.label
        static let rightButtonTitle: UIColor = UIColor.label
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

    let dividerView: DividerView = DividerView()
    
    let contentView: UIView = UIView()

    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()

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

        view.subviewsTranslatesAutoresizingMaskIntoConstraintsFalse()

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 45),

            popButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            popButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            popButton.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            popButton.widthAnchor.constraint(equalToConstant: 48),

            dismissButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            dismissButton.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 48),

            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: popButton.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: dismissButton.leftAnchor),
            
            dividerView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            dividerView.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
}
