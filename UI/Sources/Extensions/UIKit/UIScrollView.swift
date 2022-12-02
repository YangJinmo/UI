//
//  UIScrollView.swift
//  UI
//
//  Created by JMY on 2022/03/03.
//

import UIKit.UIScrollView

extension UIScrollView {
    convenience init(scrollIndicator: Bool) {
        self.init(frame: .zero)

        showsVerticalScrollIndicator = scrollIndicator
        showsHorizontalScrollIndicator = scrollIndicator
    }

    var isAtTop: Bool {
        return contentOffset.y == 0
    }

    var isOverflowVertical: Bool {
        return contentSize.height > bounds.height && bounds.height > 0
    }

    func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
        layoutIfNeeded()

        guard isOverflowVertical else {
            return false
        }

        let contentOffsetBottom = contentOffset.y + bounds.height
        return contentOffsetBottom >= contentSize.height - tolerance
    }

    func scrollToBottom(up: CGFloat = 0, animated: Bool = true) {
        layoutIfNeeded()

        guard isOverflowVertical else {
            return
        }

        let y = contentSize.height - bounds.height + contentInset.bottom + safeAreaInsets.bottom + up
        let point = CGPoint(x: 0, y: y)
        setContentOffset(point, animated: animated)
    }

    func scrollToTop(down: CGFloat = 0, right: CGFloat = 0, animated: Bool = true) {
        guard !isAtTop else {
            return
        }

        let point = CGPoint(
            x: right - contentInset.left,
            y: down - contentInset.top
        )
        setContentOffset(point, animated: animated)
    }

    fileprivate struct AssociatedKeys {
        static var kKeyScrollViewVerticalIndicator = "_verticalScrollIndicator"
        static var kKeyScrollViewHorizontalIndicator = "_horizontalScrollIndicator"
    }

    /// The vertical scroll indicator view.
    var verticalScroller: UIView {
        if objc_getAssociatedObject(self, #function) == nil {
            objc_setAssociatedObject(self, #function, self.safeValueForKey(AssociatedKeys.kKeyScrollViewVerticalIndicator), objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        return objc_getAssociatedObject(self, #function) as! UIView
    }

    /// The horizontal scroll indicator view.
    var horizontalScroller: UIView {
        if objc_getAssociatedObject(self, #function) == nil {
            objc_setAssociatedObject(self, #function, self.safeValueForKey(AssociatedKeys.kKeyScrollViewHorizontalIndicator), objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        return objc_getAssociatedObject(self, #function) as! UIView
    }

    fileprivate func safeValueForKey(_ key: String) -> AnyObject {
        let instanceVariable: Ivar = class_getInstanceVariable(type(of: self), key.cString(using: String.Encoding.utf8)!)!
        return object_getIvar(self, instanceVariable) as AnyObject
    }
}
