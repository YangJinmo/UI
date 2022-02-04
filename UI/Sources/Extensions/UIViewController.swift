//
//  UIViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

extension UIViewController {
    static func from(storyboardName: UIStoryboard.Name, bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.filename, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: Self.identifier) as? Self ?? Self()
    }

    func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        viewControllerToPresent.modalTransitionStyle = .coverVertical
        present(viewControllerToPresent, animated: true, completion: completion)
    }

    func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }

    // MARK: - UINavigationController

    func presentWithNavigationController(_ rootViewController: UIViewController, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        present(navigationController, completion: completion)
    }

    func pushViewController(_ viewController: UIViewController, hidesBottomBarWhenPushed: Bool = true) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController?.pushViewController(viewController, animated: true)
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func popToViewController(_ viewController: UIViewController) {
        navigationController?.popToViewController(viewController, animated: true)
    }

    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - UIAlertController

    func alert(
        title: String? = nil,
        message: String? = nil,
        confirmHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
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
        let alertController = UIAlertController(
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
        let alertController = UIAlertController(
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

    // MARK: - Toast

    func toast(_ text: String?, bottom: Bool = false) {
        guard !text.isNilOrEmpty, let keyWindow = UIWindow.key else { return }

        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        toastLabel.textColor = .systemBackground
        toastLabel.textAlignment = .center
        toastLabel.text = text
        toastLabel.font = .systemFont(ofSize: 16, weight: .bold)
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.layer.cornerRadius = 6
        toastLabel.clipsToBounds = true
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0
        toastLabel.spaceBetweenTheLines()

        let margin: CGFloat = 36
        let width: CGFloat = toastLabel.intrinsicContentSize.width + margin
        let height: CGFloat = toastLabel.intrinsicContentSize.height + margin

        keyWindow.addSubview(toastLabel)

        if bottom {
            let bottomConstant: CGFloat = keyWindow.safeAreaInsets.bottom + 64
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toastLabel.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor, constant: -bottomConstant),
                toastLabel.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                toastLabel.widthAnchor.constraint(equalToConstant: width),
                toastLabel.heightAnchor.constraint(equalToConstant: height),
            ])
        } else {
            toastLabel.frame.size.width = width
            toastLabel.frame.size.height = height
            toastLabel.center = keyWindow.center
        }

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 1, options: .curveEaseIn, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
}
