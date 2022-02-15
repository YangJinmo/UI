//
//  NSMutableAttributedString.swift
//  UI
//
//  Created by Jmy on 2022/02/04.
//

import UIKit

extension NSMutableAttributedString {
    @discardableResult
    func string(_ string: String, color: UIColor = .black) -> NSMutableAttributedString {
        append(
            NSMutableAttributedString(string: string)
                .foregroundColor(color)
        )
        return self
    }

    @discardableResult
    func string(_ string: String, font: UIFont) -> NSMutableAttributedString {
        append(
            NSMutableAttributedString(string: string)
                .font(font)
        )
        return self
    }

    @discardableResult
    func stringUnderline(_ string: String) -> NSMutableAttributedString {
        append(
            NSMutableAttributedString(string: string)
                .underline()
        )
        return self
    }

    @discardableResult
    func light(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .light)).foregroundColor(color))
        return self
    }

    @discardableResult
    func regular(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .regular)).foregroundColor(color))
        return self
    }

    @discardableResult
    func medium(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .medium)).foregroundColor(color))
        return self
    }

    @discardableResult
    func bold(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .bold)).foregroundColor(color))
        return self
    }

    @discardableResult
    func lightAndUnderline(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .bold)).foregroundColor(color).underline())
        return self
    }

    @discardableResult
    func regularAndUnderline(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .bold)).foregroundColor(color).underline())
        return self
    }

    @discardableResult
    func mediumAndUnderline(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .bold)).foregroundColor(color).underline())
        return self
    }

    @discardableResult
    func boldAndUnderline(_ text: String, size: CGFloat = 13, color: UIColor = .black) -> NSMutableAttributedString {
        append(NSMutableAttributedString(string: string).font(.systemFont(ofSize: size, weight: .bold)).foregroundColor(color).underline())
        return self
    }
}
