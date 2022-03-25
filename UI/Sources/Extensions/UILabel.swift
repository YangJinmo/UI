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

    static func navigationTitleLabel(_ text: String? = nil) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }

    static func makeForTitle(_ text: String? = nil) -> UILabel {
        let label = UILabel(text, .title)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.textAlignment = .center
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
    func spaceBetweenTheLines(_ alignment: NSTextAlignment = .left, _ lineSpacing: CGFloat = 2.0) {
        guard let text = self.text else {
            return
        }

        let mutableAttributedString = NSMutableAttributedString(string: text)
        let mutableParagraphStyle = NSMutableParagraphStyle()
        mutableParagraphStyle.lineSpacing = lineSpacing
        mutableParagraphStyle.alignment = alignment
        mutableAttributedString.addAttribute(.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, mutableAttributedString.length))
        attributedText = mutableAttributedString
    }
}
