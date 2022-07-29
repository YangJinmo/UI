//
//  TextViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/29.
//

import UIKit

final class TextViewController: BaseTabViewController {
    // MARK: - Constants

    private enum Font {
        static let textView: UIFont = .systemFont(ofSize: 24, weight: .semibold)
    }

    // MARK: - Views

    private lazy var textView: UITextView = {
        let textView = UITextView()
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

    override convenience init() {
        self.init(title: "TextViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.add(
            textView,
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

        addPopButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addObserverKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeObserverKeyboard()
    }

    private func addObserverKeyboard() {
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
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        let keybaordHeight = keyboardFrame.cgRectValue.height
        let isKeyboard = notification.name == UIResponder.keyboardWillShowNotification

        bottomConstraint?.constant = isKeyboard ? -keybaordHeight : 0

        if let durationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
           let curveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            let duration = durationNumber.doubleValue
            let curve = curveNumber.uintValue
            let options = UIView.AnimationOptions(rawValue: curve)

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

// MARK: - UITextViewDelegate

extension TextViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else {
            return
        }

        let totalLength = text.count
        let newlineCount = text.filter { $0 == "\n" }.count
        print("Total characters are \(totalLength) of which \(newlineCount) are newLines total of all characters counting newlines twice is \(totalLength + newlineCount)")
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 50000 // maxLength
    }
}
