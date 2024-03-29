//
//  UIViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/05.
//

import UIKit.UIViewController

extension UIViewController {
    var navigationBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.navigationBarHeight
        }

        return navigationController?.navigationBar.frame.height ?? view.navigationBarHeight
    }

    var tabBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.tabBarHeight
        }

        return tabBarController?.tabBar.frame.height ?? view.tabBarHeight
    }

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var barHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0)
            + (navigationController?.navigationBar.frame.height ?? 0.0)
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
            Log.info("could not get scene delegate ")
            return
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

    /// http://stackoverflow.com/questions/24825123/get-the-current-view-controller-from-the-app-delegate
    func currentViewController() -> UIViewController {
        func findBestViewController(_ controller: UIViewController?) -> UIViewController? {
            if let presented = controller?.presentedViewController { // Presented界面
                return findBestViewController(presented)
            } else {
                switch controller {
                case is UISplitViewController: // Return right hand side
                    let split = controller as? UISplitViewController
                    guard split?.viewControllers.isEmpty ?? true else {
                        return findBestViewController(split?.viewControllers.last)
                    }
                case is UINavigationController: // Return top view
                    let navigation = controller as? UINavigationController
                    guard navigation?.viewControllers.isEmpty ?? true else {
                        return findBestViewController(navigation?.topViewController)
                    }
                case is UITabBarController: // Return visible view
                    let tab = controller as? UITabBarController
                    guard tab?.viewControllers?.isEmpty ?? true else {
                        return findBestViewController(tab?.selectedViewController)
                    }
                default: break
                }
            }
            return controller
        }
        return findBestViewController(UIApplication.sharedKeyWindow?.rootViewController) ?? UIViewController()
    }

    func findChildViewControllerOfType(_ klass: AnyClass) -> UIViewController? {
        for child in children {
            if child.isKind(of: klass) {
                return child
            }
        }
        return nil
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
                title: "확인",
                style: .cancel,
                handler: confirmHandler
            )
        )
        present(alertController, animated: true, completion: completion)
    }

    func alertTwoOptions(
        title: String? = nil,
        message: String? = nil,
        defaultHandler: ((UIAlertAction) -> Void)? = nil,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        [
            UIAlertAction(
                title: "확인",
                style: .default,
                handler: defaultHandler
            ),
            UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: cancelHandler
            ),
        ].forEach {
            alertController.addAction($0)
        }
        present(alertController, animated: true, completion: completion)
    }

    func alertActions(
        title: String? = nil,
        message: String? = nil,
        actions: UIAlertAction...,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        completion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
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

    func toast(_ text: String?, bottom: Bool = false, view: UIView? = nil) {
        guard !text.isNilOrEmpty, let keyWindow = view ?? UIApplication.sharedKeyWindow else {
            return
        }

        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        toastLabel.textColor = .systemBackground
        toastLabel.textAlignment = .center
        toastLabel.text = text
        toastLabel.font = .systemFont(ofSize: 16, weight: .bold)
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
