//
//  TextViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/29.
//

import UIKit

final class TextViewController: BaseTabViewController {
    // MARK: - Properties

    var isScrollToBottom = false
    var scrollToBottomUpHeight: CGFloat = 0

    private let keyboardNotifications: [Notification.Name] = [
        UIResponder.keyboardWillChangeFrameNotification,
    ]

    private var isScrollViewDidEndScrollingAnimation = true

    private enum Font {
        static let textView: UIFont = .systemFont(ofSize: 24, weight: .semibold)
    }

    // MARK: - Views

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = Font.textView
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        textView.keyboardDismissMode = .interactive
        textView.delegate = self
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addObserverKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeObserverKeyboard()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.add(
            textView,
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor
        )

        bottomConstraint = NSLayoutConstraint(
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

    private func addObserverKeyboard() {
        keyboardNotifications.forEach {
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: $0, object: nil)
        }
    }

    private func removeObserverKeyboard() {
        keyboardNotifications.forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }
    }

    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ isKeyboardWillShow: Bool, _ keyboardFrame: CGRect) -> Void)?
    ) {
        guard let userInfo = notification.userInfo else {
            return
        }

        let isKeyboardWillShow = notification.name == UIResponder.keyboardWillShowNotification

        let keyboardFrameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrame = userInfo[keyboardFrameKey] as? CGRect ?? .zero

        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = userInfo[durationKey] as? Double ?? 0.25

        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = userInfo[curveKey] as? Int ?? 7
        let curve = UIView.AnimationCurve(rawValue: curveValue) ?? .linear

        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            animations?(isKeyboardWillShow, keyboardFrame)

            self.view.layoutIfNeeded()
        }

        animator.startAnimation()
    }

    @objc dynamic func handleKeyboard2(_ notification: NSNotification) {
        animateWithKeyboard(notification: notification) { isKeyboardWillShow, keyboardFrame in
            self.bottomConstraint?.constant = isKeyboardWillShow ? -keyboardFrame.height : 0
        }
    }

    // TODO: - 보이지 않는 화면으로 스크롤 한 후 커서를 터치하면 기존에 있던 커서로 스크롤 되는 문제
    @objc private func handleKeyboard(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }

        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7
        var options = UIView.AnimationOptions(rawValue: curve << 16)
        options.update(with: .layoutSubviews)

        let contentAbsoluteFrame = view.convert(view.frame, to: nil)
        let offset = contentAbsoluteFrame.maxY - keyboardFrame.minY
        let keyboardHeight = max(0, offset)

        view.layoutIfNeeded()

        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            self?.bottomConstraint?.constant = -keyboardHeight // isKeyboardWillShow ? -keyboardFrame.height : 0
            self?.view.layoutIfNeeded()
        }) { _ in
//            if isKeyboardWillShow, self.isScrollToBottom {
//                self.scrollView.scrollToBottom(up: self.scrollToBottomUpHeight)
//            }
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

// MARK: - UIScrollViewDelegate

extension TextViewController: UIScrollViewDelegate {
    private func scrollViewWillBeginScrolling(_ scrollView: UIScrollView) {
        isScrollViewDidEndScrollingAnimation = false
        scrollView.contentOffset.y.description.log()

//        view.endEditing(true)
    }

    private func scrollViewDidEndScrolling(_ scrollView: UIScrollView) {
//        isScrollViewDidEndScrolling = true
        scrollView.contentOffset.y.description.log()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height - scrollView.frame.height

        if scrollView.contentOffset.y >= contentHeight {
        }

        scrollView.contentOffset.y.description.log()

        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation), with: nil, afterDelay: 0.3)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isScrollViewDidEndScrollingAnimation = true
        scrollView.contentOffset.y.description.log()

        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewWillBeginScrolling(scrollView)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewWillBeginScrolling(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScrolling(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrolling(scrollView)
    }
}
