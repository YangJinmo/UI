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
    let titleLabel: UILabel =  {
        let label: UILabel = UILabel()
        label.font = Font.titleLabel
        label.textAlignment = .center
        return label
    }()
    let leftButton: UIButton = {
        let button: UIButton = UIButton()
        button.isHidden = true
        button.setImage(Image.chevronLeft, for: .normal)
        button.tintColor = Color.leftButtonTint
        return button
    }()
    let rightButton: UIButton = {
        let button: UIButton = UIButton()
        button.isHidden = true
        button.setTitle("확인", for: .normal)
        button.setTitleColor(Color.rightButtonTitle, for: .normal)
        button.titleLabel?.font = Font.rightButton
        return button
    }()
    let dividerView: DividerView = DividerView()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        view.addSubviews(
            titleView,
            leftButton,
            rightButton,
            titleLabel,
            dividerView
        )
        
        view.subviewsTranslatesAutoresizingMaskIntoConstraintsFalse()
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 45),
            
            leftButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            leftButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            leftButton.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 48),
            
            rightButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            rightButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            rightButton.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftButton.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightButton.leftAnchor),
            
            dividerView.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
    }
    
    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }
}

extension BaseViewController {
    
    // MARK: - UINavigationController
    
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, hidesBottomBarWhenPushed: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated, hidesBottomBarWhenPushed: hidesBottomBarWhenPushed)
    }
    
    func popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
}
