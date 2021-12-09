//
//  UIViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit

extension UIViewController {
    func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil) {
        present(viewControllerToPresent, animated: true, completion: completion)
    }

    func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }

    // MARK: - UINavigationController

    func presentWithNavigationController(_ rootViewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: animated, completion: completion)
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool = true, hidesBottomBarWhenPushed: Bool = true) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.popToViewController(viewController, animated: animated)
    }

    func popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    // MARK: - Toast

    func toast(_ text: String, bottom: Bool = false, margin: CGFloat = 64) {
        if text.isEmpty { return }

        let toastLabel: UILabel = UILabel()
        toastLabel.backgroundColor = UIColor.label.withAlphaComponent(0.9)
        toastLabel.textAlignment = .center
        toastLabel.textColor = .systemBackground
        toastLabel.text = text
        toastLabel.font = .systemFont(ofSize: 16, weight: .bold)
        toastLabel.numberOfLines = 0
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.layer.cornerRadius = 6
        toastLabel.clipsToBounds = true
        toastLabel.alpha = 0.0

        let width: CGFloat = toastLabel.intrinsicContentSize.width + margin
        let height: CGFloat = toastLabel.intrinsicContentSize.height + margin

        guard let window: UIWindow = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .filter({ $0.isKeyWindow }).first else { return }

        window.addSubview(toastLabel)

        if bottom {
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toastLabel.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -(window.safeAreaInsets.bottom + 64)),
                toastLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                toastLabel.widthAnchor.constraint(equalToConstant: width),
                toastLabel.heightAnchor.constraint(equalToConstant: height / 2),
            ])
        } else {
            toastLabel.frame.size.width = width
            toastLabel.frame.size.height = height
            toastLabel.center = window.center
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
