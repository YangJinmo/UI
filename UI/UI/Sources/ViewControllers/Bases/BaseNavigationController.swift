//
//  BaseNavigationController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import UIKit

class BaseNavigationController: BaseTapViewController {
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        showLeftButton()
    }
    
    // MARK: - Methods
    
    func showLeftButton() {
        leftButton.isHidden = false
    }
}
