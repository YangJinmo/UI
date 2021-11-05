//
//  BasePresentViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import Foundation

class BasePresentViewController: BaseViewController {
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        setupDismissButton()
    }
    
    // MARK: - Methods
    
    func setupDismissButton() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTouched(_:)), for: .touchUpInside)
        dismissButton.isHidden = false
    }
    
    @objc func dismissButtonTouched(_ sender: Any) {
        dismiss()
    }
}
