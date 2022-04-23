//
//  FloatingButton.swift
//  UI
//
//  Created by Jmy on 2022/03/26.
//

import UIKit

final class FloatingButton: BaseButton {
    var floatingButtonTouch: Closure?

    private enum Image {
        static let chevronUpSquare = UIImage(systemName: "chevron.up.square")
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

    override func commonInit() {
        isHidden = true
        alpha = 0
        transform = CGAffineTransform(scaleX: 0, y: 0)
        layer.add(scaleAnimation, forKey: "scale")

        setImage(Image.chevronUpSquare, for: .normal)
        addTarget(self, action: #selector(floatingButtonTouched), for: .touchUpInside)

        translatesAutoresizingMaskIntoConstraints = false

        Constraint.activate([
            widthAnchor.constraint(equalToConstant: 44),
            heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    @objc private func floatingButtonTouched() {
        floatingButtonTouch?()
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
