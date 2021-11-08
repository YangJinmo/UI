//
//  ReviewViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

final class ReviewViewController: BaseViewController {
    
    // MARK: - Views
    
    let presentButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private let vcName: String = "리뷰"
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabel(vcName)
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        view.addSubviews(
            presentButton
        )
        
        view.subviewsTranslatesAutoresizingMaskIntoConstraintsFalse()
        
        NSLayoutConstraint.activate([
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        presentButton.addTarget(self, action: #selector(presentButtonTouched(_:)), for: .touchUpInside)
    }
    
    @objc func presentButtonTouched(_ sender: Any) {
        //present(ReviewWriteViewController())
        presentWithNavigationController(ReviewWriteViewController())
    }
}
