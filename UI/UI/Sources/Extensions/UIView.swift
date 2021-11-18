//
//  UIView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

typealias Constraint = NSLayoutConstraint
typealias Constraints = [Constraint]
typealias LayoutAttribute = Constraint.Attribute
typealias LayoutRelation = Constraint.Relation

struct Anchor {
    var top, left, right, bottom, width, height: Constraint?
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    // MARK: - Layout Anchor

    @discardableResult
    func make(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        padding: UIEdgeInsets = .zero,
        width: CGFloat = 0,
        height: CGFloat = 0
    ) -> Anchor {
        var anchor = Anchor()

        if let top = top {
            anchor.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let left = left {
            anchor.left = leftAnchor.constraint(equalTo: left, constant: padding.left)
        }

        if let right = right {
            anchor.right = rightAnchor.constraint(equalTo: right, constant: -padding.right)
        }

        if let bottom = bottom {
            anchor.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if width > 0 {
            anchor.width = widthAnchor.constraint(equalToConstant: width)
        }

        if height > 0 {
            anchor.height = heightAnchor.constraint(equalToConstant: height)
        }

        [anchor.top, anchor.left, anchor.right, anchor.bottom, anchor.width, anchor.height].forEach { $0?.isActive = true }

        return anchor
    }

    func fillSuperview(padding: UIEdgeInsets = .zero) {
        make(
            top: superview?.topAnchor,
            left: superview?.leftAnchor,
            right: superview?.rightAnchor,
            bottom: superview?.bottomAnchor,
            padding: padding
        )
    }

    @discardableResult
    func remake(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        padding: UIEdgeInsets = .zero,
        width: CGFloat = 0,
        height: CGFloat = 0
    ) -> Anchor {
        remove(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
            width: width,
            height: height
        )

        return make(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
            padding: padding,
            width: width,
            height: height
        )
    }

    private func remove(
        _ view: UIView? = nil,
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        width: CGFloat = 0,
        height: CGFloat = 0
    ) {
        if let _ = top {
            remove(view, anchorY: topAnchor)
        }

        if let _ = left {
            remove(view, anchorX: leftAnchor)
        }

        if let _ = right {
            remove(view, anchorX: rightAnchor)
        }

        if let _ = bottom {
            remove(view, anchorY: bottomAnchor)
        }

        if width > 0 {
            remove(view, dimension: widthAnchor)
        }

        if height > 0 {
            remove(view, dimension: heightAnchor)
        }
    }

    private func remove(_ view: UIView? = nil, anchorX: NSLayoutXAxisAnchor) {
        if let view = view {
            view.constraints.first { $0.firstAnchor == anchorX }?.isActive = false
        } else if let superview = superview {
            superview.constraints.first { $0.firstAnchor == anchorX }?.isActive = false
        }
    }

    private func remove(_ view: UIView? = nil, anchorY: NSLayoutYAxisAnchor) {
        if let view = view {
            view.constraints.first { $0.firstAnchor == anchorY }?.isActive = false
        } else if let superview = superview {
            superview.constraints.first { $0.firstAnchor == anchorY }?.isActive = false
        }
    }

    private func remove(_ view: UIView? = nil, dimension: NSLayoutDimension) {
        if let view = view {
            view.constraints.first { $0.firstAnchor == dimension }?.isActive = false
        } else if let superview = superview {
            superview.constraints.first { $0.firstAnchor == dimension }?.isActive = false
        }
    }

    @discardableResult
    func top(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Constraint {
        let constraint: Constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func left(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Constraint {
        let constraint: Constraint = leftAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func right(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Constraint {
        let constraint: Constraint = rightAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func bottom(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Constraint {
        let constraint: Constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    func centerX(_ anchor: NSLayoutXAxisAnchor? = nil, _ constant: CGFloat = 0) {
        if let anchor = anchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        } else if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: constant).isActive = true
        }
    }

    func centerY(_ anchor: NSLayoutYAxisAnchor? = nil, _ constant: CGFloat = 0) {
        if let anchor = anchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        } else if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: constant).isActive = true
        }
    }

    func center(_ toView: UIView? = nil) {
        centerX(toView?.centerXAnchor)
        centerY(toView?.centerYAnchor)
    }

    // MARK: - Layout Attribute

    private func removeConstraint(attribute: LayoutAttribute) {
        constraints.forEach { constraint in
            if constraint.firstAttribute == attribute {
                removeConstraint(constraint)
            }
        }
    }

    func setConstraint(_ attribute: LayoutAttribute, _ constant: CGFloat, _ multiplier: CGFloat = 1) {
        removeConstraint(attribute: attribute)
        addConstraint(createConstraint(attribute: attribute, multiplier: multiplier, constant: constant))
    }

    private func createConstraint(
        attribute itemAttribute: LayoutAttribute,
        toItem: Any? = nil,
        relatedBy: LayoutRelation = .equal,
        attribute toItemAttribute: LayoutAttribute = .notAnAttribute,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> Constraint {
        return Constraint(
            item: self,
            attribute: itemAttribute,
            relatedBy: relatedBy,
            toItem: toItem,
            attribute: toItemAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }

    func width(_ constant: CGFloat, _ multiplier: CGFloat = 1.0) {
        setConstraint(.width, constant, multiplier)
    }

    func height(_ constant: CGFloat, _ multiplier: CGFloat = 1.0) {
        setConstraint(.height, constant, multiplier)
    }

    func make(
        _ view1: Any,
        _ attr1: LayoutAttribute,
        _ view2: Any?,
        _ attr2: LayoutAttribute,
        relation: LayoutRelation = .equal,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) {
        addConstraint(Constraint(view1, attr1, view2, attr2, relation))
    }

    // MARK: - VisualFormat

    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary: [String: UIView] = [String: UIView]()

        for (index, view) in views.enumerated() {
            let key: String = "v\(index)"
            viewsDictionary[key] = view
        }

        addConstraints(
            Constraint.constraints(
                withVisualFormat: format,
                options: Constraint.FormatOptions(),
                metrics: nil,
                views: viewsDictionary
            )
        )
    }
}

extension Constraint {
    convenience init(
        _ view1: Any,
        _ attr1: LayoutAttribute,
        _ view2: Any?,
        _ attr2: LayoutAttribute,
        _ relation: LayoutRelation = .equal,
        _ multiplier: CGFloat = 1.0,
        _ constant: CGFloat = 0.0
    ) {
        self.init(item: view1, attribute: attr1, relatedBy: relation, toItem: view2, attribute: attr2, multiplier: multiplier, constant: constant)
    }
}
