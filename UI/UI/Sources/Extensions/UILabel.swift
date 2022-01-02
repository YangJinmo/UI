//
//  UILabel.swift
//  UI
//
//  Created by Jmy on 2021/12/10.
//

import UIKit

extension UILabel {
    convenience init(_ text: String? = nil, _ font: UIFont? = nil) {
        self.init(frame: .zero)

        self.text = text
        self.font = font
    }

    static func makeForTitle(_ text: String? = nil) -> UILabel {
        let label = UILabel(text, .title)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }

    static func makeForSubtitle(_ text: String? = nil) -> UILabel {
        let label = UILabel(text, .subtitle)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }

    static func makeForText(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }

    /// 행간
    func spaceBetweenTheLines(_ alignment: NSTextAlignment = .center, _ lineSpacing: CGFloat = 2) {
        guard let text = self.text else { return }

        let mutableAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        let mutableParagraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = lineSpacing
        mutableParagraphStyle.alignment = alignment
        mutableAttributedString.addAttribute(.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, mutableAttributedString.length))
        attributedText = mutableAttributedString
    }
}
