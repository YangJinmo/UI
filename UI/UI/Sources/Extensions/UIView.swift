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
    var top, left, right, bottom, width, height, centerX, centerY, center: Constraint?
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func add(
        subview: UIView,
        top: NSLayoutYAxisAnchor? = nil,
        _ topConstant: CGFloat = 0.0,
        left: NSLayoutXAxisAnchor? = nil,
        _ leftConstant: CGFloat = 0.0,
        right: NSLayoutXAxisAnchor? = nil,
        _ rightConstant: CGFloat = 0.0,
        bottom: NSLayoutYAxisAnchor? = nil,
        _ bottomConstant: CGFloat = 0.0,
        width: NSLayoutDimension? = nil,
        widthConstant: CGFloat = 0.0,
        widthMultiplier: CGFloat = 1.0,
        height: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0.0,
        heightMultiplier: CGFloat = 1.0//,
//        center: Constraint? = nil
    ) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.make(top: top, topConstant, left: left, leftConstant, right: right, rightConstant, bottom: bottom, bottomConstant, width: width, widthConstant: widthConstant, widthMultiplier: widthMultiplier, height: height, heightConstant: heightConstant, heightMultiplier: heightMultiplier)
//        if center == centerX() {
//            subview.centerX(equalTo: <#T##NSLayoutXAxisAnchor?#>, constant: <#T##CGFloat#>)
//        } else if center == .centerY {
//            subview.centerY()
//        } else if center == .center {
//            subview.center()
//        }
    }

    // MARK: - Layout Anchor

    @discardableResult
    func make(
        top: NSLayoutYAxisAnchor? = nil,
        _ topConstant: CGFloat = 0.0,
        left: NSLayoutXAxisAnchor? = nil,
        _ leftConstant: CGFloat = 0.0,
        right: NSLayoutXAxisAnchor? = nil,
        _ rightConstant: CGFloat = 0.0,
        bottom: NSLayoutYAxisAnchor? = nil,
        _ bottomConstant: CGFloat = 0.0,
        width: NSLayoutDimension? = nil,
        widthConstant: CGFloat = 0.0,
        widthMultiplier: CGFloat = 1.0,
        height: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0.0,
        heightMultiplier: CGFloat = 1.0
    ) -> Anchor {
        var anchor = Anchor()
        anchor.top = make(anchorY: topAnchor, toAnchorY: top, constant: topConstant)
        anchor.left = make(anchorX: leftAnchor, toAnchorX: left, constant: leftConstant)
        anchor.right = make(anchorX: rightAnchor, toAnchorX: right, constant: -rightConstant)
        anchor.bottom = make(anchorY: bottomAnchor, toAnchorY: bottom, constant: -bottomConstant)
        anchor.width = make(dimension: widthAnchor, toDimension: width, constant: widthConstant, multiplier: widthMultiplier)
        anchor.height = make(dimension: heightAnchor, toDimension: height, constant: heightConstant, multiplier: heightMultiplier)
        // [anchor.top, anchor.left, anchor.right, anchor.bottom, anchor.width, anchor.height].forEach { $0?.isActive = true }
        return anchor
    }

    @discardableResult
    func remake(
        top: NSLayoutYAxisAnchor? = nil,
        _ topConstant: CGFloat = 0.0,
        left: NSLayoutXAxisAnchor? = nil,
        _ leftConstant: CGFloat = 0.0,
        right: NSLayoutXAxisAnchor? = nil,
        _ rightConstant: CGFloat = 0.0,
        bottom: NSLayoutYAxisAnchor? = nil,
        _ bottomConstant: CGFloat = 0.0,
        width: NSLayoutDimension? = nil,
        widthConstant: CGFloat = 0.0,
        widthMultiplier: CGFloat = 1.0,
        height: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0.0,
        heightMultiplier: CGFloat = 1.0
    ) -> Anchor {
        remove(top: top, left: left, right: right, bottom: bottom, width: width, height: height)
        return make(top: top, topConstant, left: left, leftConstant, right: right, rightConstant, bottom: bottom, bottomConstant, width: width, widthConstant: widthConstant, widthMultiplier: widthMultiplier, height: height, heightConstant: heightConstant, heightMultiplier: heightMultiplier)
    }

    private func remove(
        _ view: UIView? = nil,
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        width: NSLayoutDimension? = nil,
        height: NSLayoutDimension? = nil
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

        if let _ = width {
            remove(view, dimension: widthAnchor)
        }

        if let _ = height {
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

    func edges(_ view: UIView? = nil) {
        if let view = view {
            make(
                top: view.topAnchor,
                left: view.leftAnchor,
                right: view.rightAnchor,
                bottom: view.bottomAnchor
            )
        } else if let superview = superview {
            make(
                top: superview.topAnchor,
                left: superview.leftAnchor,
                right: superview.rightAnchor,
                bottom: superview.bottomAnchor
            )
        }
    }

    private func remake(anchorX: NSLayoutXAxisAnchor, toAnchorX: NSLayoutXAxisAnchor? = nil, constant: CGFloat) -> Constraint? {
        guard let toAnchorX = toAnchorX else { return nil }
        remove(anchorX: anchorX)
        return make(anchorX: anchorX, toAnchorX: toAnchorX, constant: constant)
    }

    private func remake(anchorY: NSLayoutYAxisAnchor, toAnchorY: NSLayoutYAxisAnchor? = nil, constant: CGFloat) -> Constraint? {
        guard let toAnchorY = toAnchorY else { return nil }
        remove(anchorY: anchorY)
        return make(anchorY: anchorY, toAnchorY: toAnchorY, constant: constant)
    }

    private func remake(dimension: NSLayoutDimension, toDimension: NSLayoutDimension? = nil, constant: CGFloat, multiplier: CGFloat) -> Constraint? {
        guard let toDimension = toDimension else { return nil }
        remove(dimension: dimension)
        return make(dimension: dimension, toDimension: toDimension, constant: constant, multiplier: multiplier)
    }

    private func make(anchorX: NSLayoutXAxisAnchor, toAnchorX: NSLayoutXAxisAnchor? = nil, constant: CGFloat) -> Constraint? {
        guard let toAnchorX = toAnchorX else { return nil }
        var constraint: Constraint = Constraint()
        constraint = anchorX.constraint(equalTo: toAnchorX, constant: constant)
        constraint.isActive = true
        return constraint
    }

    private func make(anchorY: NSLayoutYAxisAnchor, toAnchorY: NSLayoutYAxisAnchor? = nil, constant: CGFloat) -> Constraint? {
        guard let toAnchorY = toAnchorY else { return nil }
        var constraint: Constraint = Constraint()
        constraint = anchorY.constraint(equalTo: toAnchorY, constant: constant)
        constraint.isActive = true
        return constraint
    }

    private func make(dimension: NSLayoutDimension, toDimension: NSLayoutDimension? = nil, constant: CGFloat, multiplier: CGFloat) -> Constraint? {
        var constraint: Constraint = Constraint()

        if let toDimension = toDimension {
            constraint = dimension.constraint(equalTo: toDimension, multiplier: multiplier, constant: constant)
        } else if constant > 0.0 {
            constraint = dimension.constraint(equalToConstant: constant)
        } else {
            return nil
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func top(equalTo toAnchorY: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> Constraint? {
        return remake(anchorY: topAnchor, toAnchorY: toAnchorY, constant: constant)
    }

    @discardableResult
    func left(equalTo toAnchorX: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> Constraint? {
        return remake(anchorX: leftAnchor, toAnchorX: toAnchorX, constant: constant)
    }

    @discardableResult
    func right(equalTo toAnchorX: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> Constraint? {
        return remake(anchorX: rightAnchor, toAnchorX: toAnchorX, constant: constant)
    }

    @discardableResult
    func bottom(equalTo toAnchorY: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> Constraint? {
        return remake(anchorY: bottomAnchor, toAnchorY: toAnchorY, constant: constant)
    }

    @discardableResult
    func width(equalTo toDimension: NSLayoutDimension? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0) -> Constraint? {
        return remake(dimension: widthAnchor, toDimension: toDimension, constant: constant, multiplier: multiplier)
    }

    @discardableResult
    func height(equalTo toDimension: NSLayoutDimension? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0) -> Constraint? {
        return remake(dimension: heightAnchor, toDimension: toDimension, constant: constant, multiplier: multiplier)
    }

    @discardableResult
    func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraint {
        remove(anchorX: centerXAnchor)

        var constraint: Constraint = Constraint()

        if let anchor = anchor {
            constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        } else if let anchor = superview?.centerXAnchor {
            constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0.0) -> Constraint {
        remove(anchorY: centerYAnchor)

        var constraint: Constraint = Constraint()

        if let anchor = anchor {
            constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        } else if let anchor = superview?.centerYAnchor {
            constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
        }
        constraint.isActive = true
        return constraint
    }

    func center(_ toView: UIView? = nil) {
        centerX(equalTo: toView?.centerXAnchor)
        centerY(equalTo: toView?.centerYAnchor)
    }

    // MARK: - Layout Attribute

    private func removeConstraint(attribute: LayoutAttribute) {
        constraints.forEach { constraint in
            if constraint.firstAttribute == attribute {
                removeConstraint(constraint)
            }
        }
    }

    private func remakeConstraint(_ attribute: LayoutAttribute, _ constant: CGFloat, _ multiplier: CGFloat) {
        removeConstraint(attribute: attribute)
        addConstraint(
            Constraint(
                item: self,
                attribute: attribute,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: multiplier,
                constant: constant
            )
        )
    }

    func width(_ constant: CGFloat, _ multiplier: CGFloat = 1.0) {
        remakeConstraint(.width, constant, multiplier)
    }

    func height(_ constant: CGFloat, _ multiplier: CGFloat = 1.0) {
        remakeConstraint(.height, constant, multiplier)
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
