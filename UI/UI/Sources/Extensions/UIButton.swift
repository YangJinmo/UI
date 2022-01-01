//
//  UIButton.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit

extension UIButton {
    private enum Font {
        static let basicButton: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    }

    static func makeForBasic(_ titleText: String) -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle(titleText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Font.basicButton
        return button
    }
}
