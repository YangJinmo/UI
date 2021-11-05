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
        
        setupRightButton()
    }
    
    // MARK: - Methods
    
    func setupRightButton() {
        rightButton.addTarget(self, action: #selector(rightButtonTouched(_:)), for: .touchUpInside)
        rightButton.isHidden = false
    }
    
    @objc func rightButtonTouched(_ sender: Any) {
        dismiss()
    }
}
