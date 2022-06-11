//
//  UIAlertAction.swift
//  UI
//
//  Created by Jmy on 2021/12/08.
//

import UIKit.UIAlertController

extension UIAlertAction {
    static func `default`(_ title: String, _ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: handler)
    }

    static func cancel(_ title: String, _ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel, handler: handler)
    }

    static func destructive(_ title: String, _ handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .destructive, handler: handler)
    }
}
