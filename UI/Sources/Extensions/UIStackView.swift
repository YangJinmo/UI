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
}
