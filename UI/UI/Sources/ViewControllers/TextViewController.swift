//
//  TextViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/29.
//

import UIKit

final class TextViewController: BaseNavigationViewController {
    // MARK: - Constants

    private struct Font {
        static let textView: UIFont = .systemFont(ofSize: 24, weight: .semibold)
    }
    
    private let vcName: String = "TextViewController"

    // MARK: - Views

    private lazy var textView: UITextView = {
        let textView: UITextView = UITextView()
        textView.font = Font.textView
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        return textView
    }()

    // MARK: - Layout Constraints

    private var bottomConstraint: NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                view.removeConstraint(oldValue!)
            }
            if bottomConstraint != nil {
                view.addConstraint(bottomConstraint!)
            }
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setTitleLabel(vcName)
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.add(
            subview: textView,
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor
        )

        bottomConstraint = Constraint(
            item: textView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setObserverKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeObserverKeyboard()
    }

    private func setObserverKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeObserverKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc private func handleKeyboard(notification: NSNotification) {
        guard
            let userInfo: [AnyHashable: Any] = notification.userInfo,
            let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        let keybaordHeight: CGFloat = keyboardFrame.cgRectValue.height
        let isKeyboard: Bool = notification.name == UIResponder.keyboardWillShowNotification

        bottomConstraint?.constant = isKeyboard ? -keybaordHeight : 0

        if let durationNumber: NSNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
           let curveNumber: NSNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            let duration: Double = durationNumber.doubleValue
            let curve: UInt = curveNumber.uintValue
            let options: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: curve)

            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}
