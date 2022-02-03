//
//  NSMutableAttributedString.swift
//  UI
//
//  Created by Jmy on 2022/02/04.
//

import UIKit

extension NSMutableAttributedString {
    private func mutableAttributedStringFont(_ text: String, ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> NSMutableAttributedString {
        return NSMutableAttributedString(
            string: text,
            attributes: [.font: UIFont.systemFont(ofSize: size, weight: weight)]
        )
    }

    @discardableResult
    private func addUnderlineStyle(_ text: String) -> NSMutableAttributedString {
        let underlineStyle: Int = NSUnderlineStyle.single.rawValue
        let nsString: NSString = NSString(string: text)
        let substringRange: NSRange = nsString.range(of: text)

        addAttribute(
            .underlineStyle,
            value: underlineStyle,
            range: substringRange
        )
        return self
    }

    @discardableResult
    func light(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .light))
        return self
    }

    @discardableResult
    func regular(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .regular))
        return self
    }

    @discardableResult
    func medium(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .medium))
        return self
    }

    @discardableResult
    func bold(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .bold))
        return self
    }

    @discardableResult
    func lightAndUnderline(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .light).addUnderlineStyle(text))
        return self
    }

    @discardableResult
    func regularAndUnderline(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .regular).addUnderlineStyle(text))
        return self
    }

    @discardableResult
    func mediumAndUnderline(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .medium).addUnderlineStyle(text))
        return self
    }

    @discardableResult
    func boldAndUnderline(_ text: String, size: CGFloat = 12) -> NSMutableAttributedString {
        append(mutableAttributedStringFont(text, ofSize: size, weight: .bold).addUnderlineStyle(text))
        return self
    }
}
