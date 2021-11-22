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
    var top, left, right, bottom, width, height, centerX, centerY: Constraint?
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    // MARK: - Layout Anchors

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
        heightMultiplier: CGFloat = 1.0,
        centerX: UIView? = nil,
        _ centerXConstant: CGFloat = 0.0,
        centerY: UIView? = nil,
        _ centerYConstant: CGFloat = 0.0,
        center: UIView? = nil,
        _ centerConstant: CGFloat = 0.0,
        edges: UIView? = nil,
        _ edgesConstant: CGFloat = 0.0
    ) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.make(
            top: top, topConstant,
            left: left, leftConstant,
            right: right, rightConstant,
            bottom: bottom, bottomConstant,
            width: width, widthConstant: widthConstant, widthMultiplier: widthMultiplier,
            height: height, heightConstant: heightConstant, heightMultiplier: heightMultiplier,
            centerX: centerX, centerXConstant,
            centerY: centerY, centerYConstant,
            center: center, centerConstant,
            edges: edges, edgesConstant
        )
    }

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
        heightMultiplier: CGFloat = 1.0,
        centerX: UIView? = nil,
        _ centerXConstant: CGFloat = 0.0,
        centerY: UIView? = nil,
        _ centerYConstant: CGFloat = 0.0,
        center: UIView? = nil,
        _ centerConstant: CGFloat = 0.0,
        edges: UIView? = nil,
        _ edgesConstant: CGFloat = 0.0
    ) -> Anchor {
        var anchor = Anchor()
        anchor.top = make(anchorY: topAnchor, toAnchorY: top, constant: topConstant)
        anchor.left = make(anchorX: leftAnchor, toAnchorX: left, constant: leftConstant)
        anchor.right = make(anchorX: rightAnchor, toAnchorX: right, constant: -rightConstant)
        anchor.bottom = make(anchorY: bottomAnchor, toAnchorY: bottom, constant: -bottomConstant)
        anchor.width = make(dimension: widthAnchor, toDimension: width, constant: widthConstant, multiplier: widthMultiplier)
        anchor.height = make(dimension: heightAnchor, toDimension: height, constant: heightConstant, multiplier: heightMultiplier)
        anchor.centerX = make(anchorX: centerXAnchor, toAnchorX: centerX?.centerXAnchor, constant: centerXConstant)
        anchor.centerY = make(anchorY: centerYAnchor, toAnchorY: centerY?.centerYAnchor, constant: centerYConstant)
        if let center = center {
            anchor.centerX = make(anchorX: centerXAnchor, toAnchorX: center.centerXAnchor, constant: centerXConstant)
            anchor.centerY = make(anchorY: centerYAnchor, toAnchorY: center.centerYAnchor, constant: centerYConstant)
        }
        if let edges = edges {
            anchor.top = make(anchorY: topAnchor, toAnchorY: edges.topAnchor, constant: edgesConstant)
            anchor.left = make(anchorX: leftAnchor, toAnchorX: edges.leftAnchor, constant: edgesConstant)
            anchor.right = make(anchorX: rightAnchor, toAnchorX: edges.rightAnchor, constant: -edgesConstant)
            anchor.bottom = make(anchorY: bottomAnchor, toAnchorY: edges.bottomAnchor, constant: -edgesConstant)
        }

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
        heightMultiplier: CGFloat = 1.0,
        centerX: UIView? = nil,
        _ centerXConstant: CGFloat = 0.0,
        centerY: UIView? = nil,
        _ centerYConstant: CGFloat = 0.0,
        center: UIView? = nil,
        _ centerConstant: CGFloat = 0.0,
        edges: UIView? = nil,
        _ edgesConstant: CGFloat = 0.0
    ) -> Anchor {
        remove(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
            width: width,
            height: height,
            centerX: centerX,
            centerY: centerY,
            center: center,
            edges: edges
        )
        return make(
            top: top, topConstant,
            left: left, leftConstant,
            right: right, rightConstant,
            bottom: bottom, bottomConstant,
            width: width, widthConstant: widthConstant, widthMultiplier: widthMultiplier,
            height: height, heightConstant: heightConstant, heightMultiplier: heightMultiplier,
            centerX: centerX, centerXConstant,
            centerY: centerY, centerYConstant,
            center: center, centerConstant,
            edges: edges, edgesConstant
        )
    }

    private func remove(
        _ view: UIView? = nil,
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        width: NSLayoutDimension? = nil,
        height: NSLayoutDimension? = nil,
        centerX: UIView? = nil,
        centerY: UIView? = nil,
        center: UIView? = nil,
        edges: UIView? = nil
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
        
        if let _ = centerX {
            remove(view, anchorX: centerXAnchor)
        }

        if let _ = centerY {
            remove(view, anchorY: centerYAnchor)
        }

        if let _ = center {
            remove(view, anchorX: centerXAnchor)
            remove(view, anchorY: centerYAnchor)
        }
        
        if let _ = edges {
            remove(anchorY: topAnchor)
            remove(anchorX: leftAnchor)
            remove(anchorX: rightAnchor)
            remove(anchorY: bottomAnchor)
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

    func edges(equalTo view: UIView? = nil, constant: CGFloat = 0.0) {
        if let view = view {
            make(
                top: view.topAnchor, constant,
                left: view.leftAnchor, constant,
                right: view.rightAnchor, -constant,
                bottom: view.bottomAnchor, -constant
            )
        } else if let superview = superview {
            make(
                top: superview.topAnchor, constant,
                left: superview.leftAnchor, constant,
                right: superview.rightAnchor, -constant,
                bottom: superview.bottomAnchor, -constant
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
    func centerX(equalTo view: UIView? = nil, constant: CGFloat = 0.0) -> Constraint? {
        if let view = view {
            return remake(anchorX: centerXAnchor, toAnchorX: view.centerXAnchor, constant: constant)
        } else if let superview = superview {
            return remake(anchorX: centerXAnchor, toAnchorX: superview.centerXAnchor, constant: constant)
        }
        return nil
    }

    @discardableResult
    func centerY(equalTo view: UIView? = nil, constant: CGFloat = 0.0) -> Constraint? {
        if let view = view {
            return remake(anchorY: centerYAnchor, toAnchorY: view.centerYAnchor, constant: constant)
        } else if let superview = superview {
            return remake(anchorY: centerYAnchor, toAnchorY: superview.centerYAnchor, constant: constant)
        }
        return nil
    }

    func center(equalTo view: UIView? = nil, constant: CGFloat = 0.0) {
        centerX(equalTo: view, constant: constant)
        centerY(equalTo: view, constant: constant)
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

extension NSLayoutXAxisAnchor {
    func remove(superview: UIView) {
        superview.constraints.first { $0.firstAnchor == self }?.isActive = false
    }
}

extension NSLayoutYAxisAnchor {
    func remove(superview: UIView) {
        superview.constraints.first { $0.firstAnchor == self }?.isActive = false
    }
}

extension NSLayoutDimension {
    func remove(superview: UIView) {
        superview.constraints.first { $0.firstAnchor == self }?.isActive = false
    }
}

@objc extension NSLayoutAnchor {
    @discardableResult
    func constraint(
        _ relation: NSLayoutConstraint.Relation = .equal,
        anchor: NSLayoutAnchor,
        constant: CGFloat = 0.0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint

        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, constant: constant)

        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: constant)

        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, constant: constant)

        @unknown default:
            fatalError()
        }

        constraint.set(priority: priority, isActive: isActive)
        return constraint
    }
}

extension NSLayoutDimension {
    @discardableResult
    func constraint(
        _ relation: NSLayoutConstraint.Relation = .equal,
        anchor: NSLayoutDimension? = nil,
        constant: CGFloat = 0.0,
        multiplier: CGFloat = 1.0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint

        switch relation {
        case .equal:
            if let anchor = anchor {
                constraint = self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            } else {
                constraint = self.constraint(equalToConstant: constant)
            }

        case .greaterThanOrEqual:
            if let anchor = anchor {
                constraint = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            } else {
                constraint = self.constraint(greaterThanOrEqualToConstant: constant)
            }

        case .lessThanOrEqual:
            if let anchor = anchor {
                constraint = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            } else {
                constraint = self.constraint(lessThanOrEqualToConstant: constant)
            }

        @unknown default:
            fatalError()
        }

        constraint.set(priority: priority, isActive: isActive)
        return constraint
    }
}

extension NSLayoutConstraint {
    func set(priority: UILayoutPriority, isActive: Bool) {
        self.priority = priority
        self.isActive = isActive
    }
}
