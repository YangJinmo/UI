//
//  UIView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit.UIView

extension UIView {
    var navigationBarHeight: CGFloat {
        return 44
    }

    var tabBarHeight: CGFloat {
        return 49
    }

    var rootView: UIView {
        if let superview = superview {
            return superview.rootView
        } else {
            return self
        }
    }

    func findSuperView<T>(class superViewClass: T.Type) -> T? {
        var superview: UIView! = superview!
        var foundSuperview: UIView!

        while superview != nil && foundSuperview == nil {
            if superview.self is T {
                foundSuperview = superview
            } else {
                superview = superview.superview
            }
        }
        return foundSuperview as? T
    }

    @IBInspectable var setCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    // MARK: - Safe Area

    var safeAreaHeight: CGFloat {
        return safeAreaLayoutGuide.layoutFrame.height
    }

    var safeAreaBottom: CGFloat {
        return safeAreaInsets.bottom
    }

    func layoutFitting() {
        setNeedsLayout()
        layoutIfNeeded()
        frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    func rounded() {
        layoutIfNeeded()
        layer.cornerRadius = frame.height / 2.0
        layer.masksToBounds = true
    }

//    @discardableResult
//    func addSubviews(_ subviews: UIView...) -> UIView {
//        subviews.forEach(addSubview)
//        return self
//    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func removeAllSubviews<T: UIView>(type: T.Type) {
        subviews
            .filter { $0.isMember(of: type) }
            .forEach { $0.removeFromSuperview() }
    }

    func addTapGestureRecognizer(target: Any?, action: Selector?) {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }

    func addLongPressGestureRecognizer(target: Any?, action: Selector?) {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: target, action: action))
    }

    func addBottomBorder() {
        let dividerView = UIView()
        dividerView.backgroundColor = .secondarySystemBackground
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(dividerView)

        NSLayoutConstraint.activate([
            dividerView.leftAnchor.constraint(equalTo: leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    /// Apple System Style
    func addBottomBorderHalf() {
        let dividerView = UIView()
        dividerView.backgroundColor = .white(204)
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(dividerView)

        NSLayoutConstraint.activate([
            dividerView.leftAnchor.constraint(equalTo: leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }

    func setBottomShadow() {
        setShadow(x: 0, y: 1.6, blur: 1.6, alpha: 0.04)
    }

    func hideShadow() {
        layer.shadowOpacity = 0
    }

    func setShadow(
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat,
        alpha: Float
    ) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = alpha
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let bezierPath = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )

            let shapeLayer = CAShapeLayer()
            // shapeLayer.frame = bounds
            shapeLayer.path = bezierPath.cgPath

            layer.mask = shapeLayer
        }
    }

    // MARK: - Animate

    /// Create a shake effect.
    ///
    /// - Parameters:
    ///   - count: Shakes count. Default is 2.
    ///   - duration: Shake duration. Default is 0.15.
    ///   - translation: Shake translation. Default is 5.
    func shake(count: Float = 2, duration: TimeInterval = 0.15, translation: Float = 5) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation

        layer.add(animation, forKey: "shake")
    }

    func disturb() {
        transform = CGAffineTransform(scaleX: 0.98, y: 0.98)

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 150, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = .identity
        }, completion: nil)
    }

    func fadeIn(_ duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false

        UIView.animate(withDuration: duration) {
            self.alpha = 1
        } completion: { _ in
            completion?()
        }
    }

    func fadeOut(_ duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true

            completion?()
        }
    }

    func openAnimatePopup() {
        setScaleWithAlpha(value: 0)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            self.setScaleWithAlpha(value: 1)
        })
    }

    func closeAnimatePopup(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.5, options: .curveEaseIn, animations: {
            self.setScaleWithAlpha(value: 0)
        }) { _ in
            completion?()
        }
    }

    func setScaleWithAlpha(value: CGFloat) {
        let scaleValue: CGFloat = value == 0 ? 0.01 : value
        transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
        alpha = value
    }

    func screenshotDefender() {
        DispatchQueue.main.async {
            let textField = UITextField()
            textField.isSecureTextEntry = true

            self.addSubview(textField)

            textField.layer.removeFromSuperlayer()
            self.layer.superlayer?.insertSublayer(textField.layer, at: 0)
            textField.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }

    // MARK: - NSLayoutAnchor

    func add(
        _ subview: UIView,
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
        multiplier widthMultiplier: CGFloat = 1.0,
        height: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0.0,
        multiplier heightMultiplier: CGFloat = 1.0,
        center: UIView? = nil,
        centerX: UIView? = nil,
        centerXConstant: CGFloat = 0.0,
        centerY: UIView? = nil,
        centerYConstant: CGFloat = 0.0,
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
            width: width, widthConstant: widthConstant, multiplier: widthMultiplier,
            height: height, heightConstant: heightConstant, multiplier: heightMultiplier,
            center: center,
            centerX: centerX, centerXConstant: centerXConstant,
            centerY: centerY, centerYConstant: centerYConstant,
            edges: edges, edgesConstant
        )
    }

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
        multiplier widthMultiplier: CGFloat = 1.0,
        height: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0.0,
        multiplier heightMultiplier: CGFloat = 1.0,
        center: UIView? = nil,
        centerX: UIView? = nil,
        centerXConstant: CGFloat = 0.0,
        centerY: UIView? = nil,
        centerYConstant: CGFloat = 0.0,
        edges: UIView? = nil,
        _ edgesConstant: CGFloat = 0.0
    ) {
        if let top = top {
            make(anchorY: topAnchor, toAnchorY: top, constant: topConstant)
        }
        if let left = left {
            make(anchorX: leftAnchor, toAnchorX: left, constant: leftConstant)
        }
        if let right = right {
            make(anchorX: rightAnchor, toAnchorX: right, constant: -rightConstant)
        }
        if let bottom = bottom {
            make(anchorY: bottomAnchor, toAnchorY: bottom, constant: -bottomConstant)
        }
        make(dimension: widthAnchor, toDimension: width, constant: widthConstant, multiplier: widthMultiplier)
        make(dimension: heightAnchor, toDimension: height, constant: heightConstant, multiplier: heightMultiplier)
        if let centerX = centerX {
            make(anchorX: centerXAnchor, toAnchorX: centerX.centerXAnchor, constant: centerXConstant)
        }
        if let centerY = centerY {
            make(anchorY: centerYAnchor, toAnchorY: centerY.centerYAnchor, constant: centerYConstant)
        }
        if let center = center {
            make(anchorX: centerXAnchor, toAnchorX: center.centerXAnchor, constant: centerXConstant)
            make(anchorY: centerYAnchor, toAnchorY: center.centerYAnchor, constant: centerYConstant)
        }
        if let edges = edges {
            make(anchorY: topAnchor, toAnchorY: edges.topAnchor, constant: edgesConstant)
            make(anchorX: leftAnchor, toAnchorX: edges.leftAnchor, constant: edgesConstant)
            make(anchorX: rightAnchor, toAnchorX: edges.rightAnchor, constant: -edgesConstant)
            make(anchorY: bottomAnchor, toAnchorY: edges.bottomAnchor, constant: -edgesConstant)
        }
    }

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
        multiplier widthMultiplier: CGFloat = 1.0,
        height: NSLayoutDimension? = nil,
        heightConstant: CGFloat = 0.0,
        multiplier heightMultiplier: CGFloat = 1.0,
        centerX: UIView? = nil,
        _ centerXConstant: CGFloat = 0.0,
        centerY: UIView? = nil,
        _ centerYConstant: CGFloat = 0.0,
        center: UIView? = nil,
        _ centerConstant: CGFloat = 0.0,
        edges: UIView? = nil,
        _ edgesConstant: CGFloat = 0.0
    ) {
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
        make(
            top: top, topConstant,
            left: left, leftConstant,
            right: right, rightConstant,
            bottom: bottom, bottomConstant,
            width: width, widthConstant: widthConstant, multiplier: widthMultiplier,
            height: height, heightConstant: heightConstant, multiplier: heightMultiplier,
            center: center,
            centerX: centerX, centerXConstant: centerXConstant,
            centerY: centerY, centerYConstant: centerYConstant,
            edges: edges, edgesConstant
        )
    }

    func remove(
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
        guard let superview = superview else {
            return
        }
        if let _ = top {
            superview.remove(anchorY: topAnchor)
        }
        if let _ = left {
            superview.remove(anchorX: leftAnchor)
        }
        if let _ = right {
            superview.remove(anchorX: rightAnchor)
        }
        if let _ = bottom {
            superview.remove(anchorY: bottomAnchor)
        }
        if let _ = width {
            superview.remove(dimension: widthAnchor)
        }
        if let _ = height {
            superview.remove(dimension: heightAnchor)
        }
        if let centerX = centerX {
            centerX.remove(anchorX: centerXAnchor)
        }
        if let centerY = centerY {
            centerY.remove(anchorY: centerYAnchor)
        }
        if let center = center {
            center.remove(anchorX: centerXAnchor)
            center.remove(anchorY: centerYAnchor)
        }
        if let edges = edges {
            edges.remove(anchorY: topAnchor)
            edges.remove(anchorX: leftAnchor)
            edges.remove(anchorX: rightAnchor)
            edges.remove(anchorY: bottomAnchor)
        }
    }

    func remove(anchorX: NSLayoutXAxisAnchor) {
        constraints.first { $0.firstAnchor == anchorX }?.isActive = false
    }

    func remove(anchorY: NSLayoutYAxisAnchor) {
        constraints.first { $0.firstAnchor == anchorY }?.isActive = false
    }

    func remove(dimension: NSLayoutDimension) {
        constraints.first { $0.firstAnchor == dimension }?.isActive = false
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

    @discardableResult
    func remake(anchorX: NSLayoutXAxisAnchor, toAnchorX: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }

        anchorX.remove(superview: superview)
        return make(anchorX: anchorX, toAnchorX: toAnchorX, constant: constant)
    }

    @discardableResult
    private func remake(anchorY: NSLayoutYAxisAnchor, toAnchorY: NSLayoutYAxisAnchor, constant: CGFloat) -> NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }

        anchorY.remove(superview: superview)
        return make(anchorY: anchorY, toAnchorY: toAnchorY, constant: constant)
    }

    @discardableResult
    private func remake(dimension: NSLayoutDimension, toDimension: NSLayoutDimension? = nil, constant: CGFloat, multiplier: CGFloat) -> NSLayoutConstraint? {
        guard let superview = superview else {
            return nil
        }

        dimension.remove(superview: superview)
        return make(dimension: dimension, toDimension: toDimension, constant: constant, multiplier: multiplier)
    }

    @discardableResult
    private func make(anchorX: NSLayoutXAxisAnchor, toAnchorX: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint? {
        return anchorX.constraint(anchor: toAnchorX, constant: constant)
    }

    @discardableResult
    private func make(anchorY: NSLayoutYAxisAnchor, toAnchorY: NSLayoutYAxisAnchor, constant: CGFloat) -> NSLayoutConstraint? {
        return anchorY.constraint(anchor: toAnchorY, constant: constant)
    }

    @discardableResult
    private func make(dimension: NSLayoutDimension, toDimension: NSLayoutDimension? = nil, constant: CGFloat, multiplier: CGFloat) -> NSLayoutConstraint? {
        if let toDimension = toDimension {
            return dimension.constraint(anchor: toDimension, constant: constant, multiplier: multiplier)
        } else if constant > 0.0 {
            return dimension.constraint(constant: constant)
        } else {
            return nil
        }
    }

    @discardableResult
    func top(equalTo toAnchorY: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
        return remake(anchorY: topAnchor, toAnchorY: toAnchorY, constant: constant)
    }

    @discardableResult
    func left(equalTo toAnchorX: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
        return remake(anchorX: leftAnchor, toAnchorX: toAnchorX, constant: constant)
    }

    @discardableResult
    func right(equalTo toAnchorX: NSLayoutXAxisAnchor, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
        return remake(anchorX: rightAnchor, toAnchorX: toAnchorX, constant: -constant)
    }

    @discardableResult
    func bottom(equalTo toAnchorY: NSLayoutYAxisAnchor, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
        return remake(anchorY: bottomAnchor, toAnchorY: toAnchorY, constant: -constant)
    }

    @discardableResult
    func width(equalTo toDimension: NSLayoutDimension? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
        return remake(dimension: widthAnchor, toDimension: toDimension, constant: constant, multiplier: multiplier)
    }

    @discardableResult
    func height(equalTo toDimension: NSLayoutDimension? = nil, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
        return remake(dimension: heightAnchor, toDimension: toDimension, constant: constant, multiplier: multiplier)
    }

    @discardableResult
    func centerX(equalTo view: UIView? = nil, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
        if let view = view {
            return remake(anchorX: centerXAnchor, toAnchorX: view.centerXAnchor, constant: constant)
        } else if let superview = superview {
            return remake(anchorX: centerXAnchor, toAnchorX: superview.centerXAnchor, constant: constant)
        }
        return nil
    }

    @discardableResult
    func centerY(equalTo view: UIView? = nil, constant: CGFloat = 0.0) -> NSLayoutConstraint? {
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

    // superview

    func removeAnchor(
        top: UIView? = nil,
        left: UIView? = nil,
        right: UIView? = nil,
        bottom: UIView? = nil,
        width: UIView? = nil,
        height: UIView? = nil,
        centerX: UIView? = nil,
        centerY: UIView? = nil,
        center: UIView? = nil,
        edges: UIView? = nil
    ) {
        if let top = top, let superview = top.superview {
            superview.remove(anchorY: top.topAnchor)
        }
        if let left = left, let superview = left.superview {
            superview.remove(anchorX: left.leftAnchor)
        }
        if let right = right, let superview = right.superview {
            superview.remove(anchorX: right.rightAnchor)
        }
        if let bottom = bottom, let superview = bottom.superview {
            superview.remove(anchorY: bottom.bottomAnchor)
        }
        if let width = width, let superview = width.superview {
            superview.remove(dimension: width.widthAnchor)
        }
        if let height = height, let superview = height.superview {
            superview.remove(dimension: height.heightAnchor)
        }
        if let centerX = centerX, let superview = centerX.superview {
            superview.remove(anchorX: centerX.centerXAnchor)
        }
        if let centerY = centerY, let superview = centerY.superview {
            superview.remove(anchorY: centerY.centerYAnchor)
        }
        if let center = center, let superview = center.superview {
            superview.remove(anchorX: center.centerXAnchor)
            superview.remove(anchorY: center.centerYAnchor)
        }
        if let edges = edges, let superview = edges.superview {
            superview.remove(anchorY: edges.topAnchor)
            superview.remove(anchorX: edges.leftAnchor)
            superview.remove(anchorX: edges.rightAnchor)
            superview.remove(anchorY: edges.bottomAnchor)
        }
    }

    // MARK: - NSLayoutConstraint

    /// Removes specified set of constraints from the views in the receiver's subtree and from the receiver itself.
    ///
    /// - parameter constraints: A set of constraints that need to be removed.
    func removeConstraintsFromSubtree(_ constraints: Set<NSLayoutConstraint>) {
        var constraintsToRemove = [NSLayoutConstraint]()

        for constraint in self.constraints {
            if constraints.contains(constraint) {
                constraintsToRemove.append(constraint)
            }
        }

        removeConstraints(constraintsToRemove)

        for view in subviews {
            view.removeConstraintsFromSubtree(constraints)
        }
    }

    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach { constraint in
            if constraint.firstAttribute == attribute {
                removeConstraint(constraint)
            }
        }
    }

    public func removeAllConstraints() {
        var _superview = superview

        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        removeConstraints(constraints)
        translatesAutoresizingMaskIntoConstraints = true
    }

    private func remakeConstraint(_ attribute: NSLayoutConstraint.Attribute, _ constant: CGFloat, _ multiplier: CGFloat) {
        removeConstraint(attribute: attribute)
        addConstraint(
            NSLayoutConstraint(
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

    // MARK: - Visual Format Language

    /**
     H: (Horizontal) //horizontal direction
     V: (Vertical) //vertical direction
     | (pipe) //superview
     - (dash) //standard spacing (generally 8 points)
     [] (brackets) //name of the object (uilabel, unbutton, uiview, etc.)
     () (parentheses) //size of the object
     == equal widths //can be omitted
     -16- non standard spacing (16 points)
     <= less than or equal to
     >= greater than or equal to
     @250 priority of the constraint //can have any value between 0 and 1000
     */

    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()

        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }

        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: NSLayoutConstraint.FormatOptions(),
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
