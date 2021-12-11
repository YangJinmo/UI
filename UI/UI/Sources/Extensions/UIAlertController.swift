//
//  UIAlertController.swift
//  UI
//
//  Created by Jmy on 2021/12/08.
//

import UIKit

extension UIViewController {
    func alert(
        title: String? = nil,
        message: String? = nil,
        confirmHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "확인",
                style: .cancel,
                handler: confirmHandler
            )
        )
        present(alertController, animated: true, completion: completion)
    }

    func alertOption(
        title: String? = nil,
        message: String? = nil,
        confirmHandler: ((UIAlertAction) -> Void)? = nil,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: "확인",
                style: .default,
                handler: confirmHandler
            )
        )
        alertController.addAction(
            UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: cancelHandler
            )
        )
        present(alertController, animated: true, completion: completion)
    }

    func actionSheet(
        title: String? = nil,
        message: String? = nil,
        actions: UIAlertAction...,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        actions.forEach {
            alertController.addAction($0)
        }
        alertController.addAction(
            UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: cancelHandler
            )
        )
        present(alertController, animated: true, completion: completion)
    }
}
