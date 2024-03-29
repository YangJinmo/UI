//
//  UITextView.swift
//  UI
//
//  Created by Jmy on 2022/05/05.
//

import UIKit.UITextView

extension UITextView {
    var estimatedSize: CGSize {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        return estimatedSize
    }

    var estimatedHeight: CGFloat {
        return ceil(estimatedSize.height)
    }

    var numberOfLines: Int {
        return Int(estimatedSize.height / font!.lineHeight)
    }

    func selectedAllTextRange() {
        selectedTextRange = textRange(from: beginningOfDocument, to: endOfDocument)
    }
}
