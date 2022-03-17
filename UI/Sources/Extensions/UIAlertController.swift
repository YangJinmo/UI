//
//  UIAlertController.swift
//  UI
//
//  Created by Jmy on 2021/12/08.
//

import UIKit.UIAlertController

extension UIAlertController {
    static func alert(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    static func actionSheet(title: String?, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }

    @discardableResult
    func action(title: String?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
}
