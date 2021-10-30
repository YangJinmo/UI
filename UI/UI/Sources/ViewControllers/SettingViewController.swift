//
//  SettingViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/30.
//

import Foundation

final class SettingViewController: BaseNavigationController {
    
    // MARK: - Properties
    
    private let vcName: String = "설정"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleLabel(vcName)
    }
}
