//
//  BaseNavigationController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - Initialization
    
    convenience init(rootViewController: UIViewController, title text: String, image: UIImage?) {
        self.init(rootViewController: rootViewController)
        
        title = text
        tabBarItem.image = image
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        isNavigationBarHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
