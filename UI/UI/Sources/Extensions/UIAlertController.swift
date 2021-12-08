//
//  UIAlertController.swift
//  UI
//
//  Created by Jmy on 2021/12/08.
//

import UIKit

extension UIViewController {
    func alertController(
        style: UIAlertController.Style,
        title: String,
        message: String? = nil,
        actions: [UIAlertAction],
        cancelTitle: String = "취소",
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        actions.forEach {
            alertController.addAction($0)
        }
        alertController.addAction(
            UIAlertAction(
                title: cancelTitle,
                style: .cancel,
                handler: cancelHandler
            )
        )
        present(alertController, animated: true, completion: completion)
    }
}
