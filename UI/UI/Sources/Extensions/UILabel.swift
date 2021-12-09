//
//  UILabel.swift
//  UI
//
//  Created by Jmy on 2021/12/10.
//

import UIKit

extension UILabel {
    /// 행간
    func spaceBetweenTheLines(_ alignment: NSTextAlignment = .center, _ lineSpacing: CGFloat = 2) {
        guard let text: String = self.text else { return }

        let mutableAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        let mutableParagraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = lineSpacing
        mutableParagraphStyle.alignment = alignment
        mutableAttributedString.addAttribute(.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, mutableAttributedString.length))
        attributedText = mutableAttributedString
    }
}
