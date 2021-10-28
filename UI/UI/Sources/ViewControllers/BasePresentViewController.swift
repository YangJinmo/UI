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
        
        setRightButton()
    }
    
    // MARK: - Methods
    
    func setRightButton() {
        rightButton.isHidden = false
        rightButton.titleLabel?.text = "확인"
    }
    
    override func rightButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}
