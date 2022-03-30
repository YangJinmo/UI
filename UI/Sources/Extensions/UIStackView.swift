//
//  UIStackView.swift
//  UI
//
//  Created by Jmy on 2021/11/28.
//

import UIKit.UIStackView

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0) {
        self.init(frame: .zero)

        self.axis = axis
        self.spacing = spacing
    }

    var height: CGFloat {
        systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }

    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }

    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        for v in removedSubviews {
            if v.superview != nil {
                NSLayoutConstraint.deactivate(v.constraints)
                v.removeFromSuperview()
            }
        }
    }

    func make(viewsHidden: [UIView], viewsVisible: [UIView], animated: Bool) {
        let viewsHidden = viewsHidden.filter({ $0.superview === self })
        let viewsVisible = viewsVisible.filter({ $0.superview === self })

        let blockToSetVisibility: ([UIView], _ hidden: Bool) -> Void = { views, hidden in
            views.forEach({ $0.isHidden = hidden })
        }

        // need for smooth animation
        let blockToSetAlphaForSubviewsOf: ([UIView], _ alpha: CGFloat) -> Void = { views, alpha in
            views.forEach({ view in
                view.subviews.forEach({ $0.alpha = alpha })
            })
        }

        if !animated {
            blockToSetVisibility(viewsHidden, true)
            blockToSetVisibility(viewsVisible, false)
            blockToSetAlphaForSubviewsOf(viewsHidden, 1)
            blockToSetAlphaForSubviewsOf(viewsVisible, 1)
        } else {
            // update hidden values of all views
            // without that animation doesn't go
            let allViews = viewsHidden + viewsVisible
            layer.removeAllAnimations()
            allViews.forEach { view in
                let oldHiddenValue = view.isHidden
                view.layer.removeAllAnimations()
                view.layer.isHidden = oldHiddenValue
            }

            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    blockToSetAlphaForSubviewsOf(viewsVisible, 1)
                    blockToSetAlphaForSubviewsOf(viewsHidden, 0)

                    blockToSetVisibility(viewsHidden, true)
                    blockToSetVisibility(viewsVisible, false)
                    self.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
}
