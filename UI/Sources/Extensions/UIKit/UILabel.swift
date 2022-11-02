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

    // MARK: - Paragraph Style

    func lineSpacing(_ alignment: NSTextAlignment = .left, _ lineSpacing: CGFloat = 2.0, numberOfLines: Int = 0) {
        guard let text = text else {
            return
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineBreakStrategy = .hangulWordPriority

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString

        self.numberOfLines = numberOfLines

        sizeToFit()
    }

    func contentSize() -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode

        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
        ]

        let contentSize: CGSize = text!.boundingRect(
            with: frame.size,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes as [NSAttributedString.Key: Any],
            context: nil
        ).size

        return contentSize
    }

    func makeTransparent() {
        isOpaque = false
        backgroundColor = .clear
    }

    func setFrameWithString(_ string: String, width: CGFloat) {
        numberOfLines = 0
        let attributes = [
            NSAttributedString.Key.font: font,
        ]
        let resultSize: CGSize = string.boundingRect(
            with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attributes as [NSAttributedString.Key: Any],
            context: nil
        ).size
        let resultHeight: CGFloat = resultSize.height
        let resultWidth: CGFloat = resultSize.width
        var frame: CGRect = self.frame
        frame.size.height = resultHeight
        frame.size.width = resultWidth
        self.frame = frame
    }

    @IBInspectable
    var underline: Bool {
        get {
            return self.underline
        }
        set {
            guard let text: String = text else {
                return
            }
            let textAttributes = NSMutableAttributedString(string: text)
            if newValue {
                textAttributes.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
            } else {
                textAttributes.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
            }
            attributedText = textAttributes
        }
    }
}
