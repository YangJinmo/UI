//
//  FloatingButton.swift
//  UI
//
//  Created by Jmy on 2022/03/26.
//

import UIKit
import WebKit

final class FloatingButton: UIButton {
    // MARK: - Properties

    enum Mode {
        case scrollToTop
        case goBack
    }

    private var mode: Mode!
    private var webView: WKWebView!
    private var view: UIView!
    private var scrollView: UIScrollView!

    private let inset = 16.0
    private let bottomToolBarHeight = 60.0

    static func goBack(view: UIView, webView: WKWebView) -> FloatingButton {
        FloatingButton(mode: .goBack, view: view, webView: webView)
    }

    static func scrollToTop(view: UIView, scrollView: UIScrollView) -> FloatingButton {
        FloatingButton(mode: .scrollToTop, view: view, scrollView: scrollView)
    }

    // MARK: - View Life Cycle

    init(mode: Mode, view: UIView, webView: WKWebView) {
        self.mode = mode

        self.view = view
        self.webView = webView

        super.init(frame: .zero)

        commonInit()
    }

    init(mode: Mode, view: UIView, scrollView: UIScrollView) {
        self.mode = mode

        self.view = view
        self.scrollView = scrollView

        super.init(frame: .zero)

        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func commonInit() {
        setImage(mode == .goBack ? .arrowLeft : .arrowUp, for: .normal)
        addTarget(self, action: #selector(floatingButtonTouched), for: .touchUpInside)

        isHidden = true
        alpha = 0

        tintColor = .black
        backgroundColor = .white

        layer.cornerRadius = 21
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = CGColor.rgba(247, 248, 249, 1)
        layer.setShadow(x: 0, y: 4, blur: 4, alpha: 0.1)

        configureConstraints()
    }

    private func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 42),
            heightAnchor.constraint(equalToConstant: 42),
        ])
    }

    @objc func floatingButtonTouched() {
        mode == .goBack ? goBack() : scrollToTop()
    }

    private func goBack() {
        UIView.animate(withDuration: 0) {
            if self.webView.canGoBack {
                self.webView.goBack()
            }
        } completion: { _ in
            self.hide()
        }
    }

    private func scrollToTop() {
        UIView.animate(withDuration: 0) {
            self.scrollView.scrollToTop()
        } completion: { _ in
            self.hide()
        }
    }

    func show() {
        if mode == .goBack && !webView.canGoBack {
            return
        }

        if isHidden {
            DispatchQueue.main.async {
                self.isHidden = false

                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    self.alpha = 1
                })
            }
        }
    }

    func hide() {
        if !isHidden {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    self.alpha = 0
                }) { _ in
                    self.isHidden = true
                }
            }
        }
    }

    func remove() {
        guard superview != nil else {
            return
        }

        removeFromSuperview()
    }

    func create() {
        view.addSubview(self)

        if mode == .goBack {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -inset - bottomToolBarHeight),
            ])
        } else {
            NSLayoutConstraint.activate([
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            ])
        }
    }
}
