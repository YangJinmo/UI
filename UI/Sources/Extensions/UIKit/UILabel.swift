//
//  UILabel.swift
//  UI
//
//  Created by Jmy on 2021/12/10.
//

import UIKit.UILabel

extension UILabel {
    convenience init(
        _ text: String? = nil,
        _ font: UIFont? = nil
    ) {
        self.init(frame: .zero)

        self.text = text
        self.font = font
    }

    static func title(_ text: String? = nil) -> UILabel {
        let label = UILabel(text, .title)
        label.textAlignment = .center
        return label
    }

    static func subtitle(_ text: String? = nil) -> UILabel {
        let label = UILabel(text, .subtitle)
        return label
    }

    static func text(_ text: String? = nil) -> UILabel {
        let label = UILabel(text)
        label.lineSpacing()
        return label
    }

    func lineSpacing(_ alignment: NSTextAlignment = .left, _ lineSpacing: CGFloat = 2.0) {
        guard let text = text else {
            return
        }

        let mutableAttributedString = NSMutableAttributedString(string: text)
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = lineSpacing
        mutableParagraphStyle.alignment = alignment
        mutableAttributedString.addAttribute(.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, mutableAttributedString.length))
        attributedText = mutableAttributedString
        numberOfLines = 0
        sizeToFit()
    }
}
