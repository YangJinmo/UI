//
//  BaseNavigationController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import UIKit

class BaseNavigationController: BaseViewController {
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        setupLeftButton()
    }
    
    // MARK: - Methods
    
    func setupLeftButton() {
        leftButton.addTarget(self, action: #selector(leftButtonTouched(_:)), for: .touchUpInside)
        leftButton.isHidden = false
    }
    
    @objc func leftButtonTouched(_ sender: Any) {
        popViewController()
    }
}
