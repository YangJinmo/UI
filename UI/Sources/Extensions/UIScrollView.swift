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

    func scrollToTop(down: CGFloat = 0) {
        let y = down - contentInset.top
        let point = CGPoint(x: 0, y: y)
        setContentOffset(point, animated: true)
    }

    func scrollToBottom(up: CGFloat = 0) {
        layoutIfNeeded()

        guard contentSize.height >= bounds.size.height else {
            return
        }
        let y = contentSize.height - bounds.size.height + contentInset.bottom + safeAreaInsets.bottom + up
        let point = CGPoint(x: 0, y: y)
        setContentOffset(point, animated: true)
    }
}
