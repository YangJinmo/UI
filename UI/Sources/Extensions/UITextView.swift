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

    var numberOfLine: Int {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        return Int(estimatedSize.height / font!.lineHeight)
    }
}
