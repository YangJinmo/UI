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

    var isOverflowVertical: Bool {
        return contentSize.height > bounds.height && bounds.height > 0
    }

    func scrollToTop(down: CGFloat = 0, right: CGFloat = 0, animated: Bool = true) {
        let point = CGPoint(
            x: right - contentInset.left,
            y: down - contentInset.top
        )
        setContentOffset(point, animated: animated)
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
}
