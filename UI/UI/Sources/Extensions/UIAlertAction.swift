//
//  UIAlertAction.swift
//  UI
//
//  Created by Jmy on 2021/12/08.
//

import UIKit

extension UIAlertAction {
    convenience init(_ title: String, _ handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, style: .default, handler: handler)
    }
}
