//
//  BasePresentViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/28.
//

import Foundation

class BasePresentViewController: BaseTapViewController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showRightButton()
    }
    
    // MARK: - Methods
    
    func showRightButton() {
        rightButton.isHidden = false
    }
    
    override func rightButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}
