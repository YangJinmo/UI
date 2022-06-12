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
}
