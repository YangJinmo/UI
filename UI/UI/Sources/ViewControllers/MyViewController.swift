//
//  MyViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class MyViewController: BaseViewController {
    
    // MARK: - Views
    
    let pushButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private let vcName: String = "마이"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabel(vcName)
        setupViews()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        view.addSubviews(
            pushButton
        )
        
        view.subviewsTranslatesAutoresizingMaskIntoConstraintsFalse()
        
        NSLayoutConstraint.activate([
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pushButton.widthAnchor.constraint(equalToConstant: 45),
            pushButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        pushButton.addTarget(self, action: #selector(pushButtonTouched(_:)), for: .touchUpInside)
    }
    
    @objc func pushButtonTouched(_ sender: Any) {
        pushViewController(SettingViewController())
    }
}
