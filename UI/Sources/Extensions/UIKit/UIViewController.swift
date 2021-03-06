//
//  UIViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit.UIViewController

extension UIViewController {
    var tabBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.tabBarHeight
        }

        return tabBarController?.tabBar.frame.height ?? 49
    }

    var navigationBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.navigationBarHeight
        }

        return navigationController?.navigationBar.frame.height ?? 56
    }

    // MARK: - Safe Area

    var safeAreaHeight: CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height
    }

    var safeAreaBottom: CGFloat {
        return view.safeAreaInsets.bottom
    }

    // MARK: - Keyboard

    func hideKeyboardWhenTappedAround() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Window

    func resetWindow() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("could not get scene delegate ")
        }
        sceneDelegate.window?.rootViewController = self
    }

    // MARK: - Storyboard

    static func from(storyboardName: UIStoryboard.Name, bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.filename, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: Self.identifier) as? Self ?? Self()
    }

    // MARK: - Modal

    func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalTransitionStyle = .coverVertical
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: completion)
    }

    func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }

    var isModal: Bool {
        if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false

//        return presentingViewController != nil
//            || navigationController?.presentingViewController?.presentedViewController == navigationController
//            || tabBarController?.presentingViewController is UITabBarController
    }

    // MARK: - Navigation Controller

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
                title: "??????",
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
                title: "??????",
                style: .default,
                handler: confirmHandler
            )
        )
        alertController.addAction(
            UIAlertAction(
                title: "??????",
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
                title: "??????",
                style: .cancel,
                handler: cancelHandler
            )
        )
        present(alertController, animated: true, completion: completion)
    }

    // MARK: - Toast

    func toast(_ text: String?, bottom: Bool = false) {
        guard !text.isNilOrEmpty, let keyWindow = UIWindow.key else {
            return
        }

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
        toastLabel.lineSpacing(.center)

        let margin: CGFloat = 36.0
        let width: CGFloat = toastLabel.intrinsicContentSize.width + margin
        let height: CGFloat = toastLabel.intrinsicContentSize.height + margin

        keyWindow.addSubview(toastLabel)

        if bottom {
            let bottomConstant: CGFloat = keyWindow.safeAreaInsets.bottom + 64.0
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            Constraint.activate([
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
