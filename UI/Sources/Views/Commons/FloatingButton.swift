//
//  FloatingButton.swift
//  UI
//
//  Created by Jmy on 2022/03/26.
//

import UIKit

final class FloatingButton: UIButton {
    // MARK: - Properties

    private enum Image {
        static let arrowUpSquareFill = UIImage(systemName: "arrow.up.square.fill")
    }

    private lazy var scaleAnimation: CABasicAnimation = {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.4
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.00
        scaleAnimation.toValue = 1.05
        return scaleAnimation
    }()

    // MARK: - Views

    private var view: UIView!
    private var scrollView: UIScrollView!

    // MARK: - View Life Cycle

    init(view: UIView, scrollView: UIScrollView) {
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
        isHidden = true
        alpha = 0
        transform = CGAffineTransform(scaleX: 0, y: 0)
        layer.add(scaleAnimation, forKey: "scale")

        setImage(Image.arrowUpSquareFill, for: .normal)
        tintColor = .base
        addTarget(self, action: #selector(floatingButtonTouched), for: .touchUpInside)

        translatesAutoresizingMaskIntoConstraints = false

        Constraint.activate([
            widthAnchor.constraint(equalToConstant: 56),
            heightAnchor.constraint(equalToConstant: 56),
        ])

        view.addSubview(self)

        Constraint.activate([
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    @objc private func floatingButtonTouched() {
        scrollToTop()
    }

    func scrollToTop() {
        UIView.animate(withDuration: 0) {
            self.scrollView.scrollToTop()
        } completion: { _ in
            self.hide()
        }
    }

    func show() {
        if isHidden {
            DispatchQueue.main.async {
                self.isHidden = false

                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    self.alpha = 1
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }

    func hide() {
        if !isHidden {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                    self.alpha = 0
                    self.transform = CGAffineTransform(scaleX: 0, y: 0)
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
}
