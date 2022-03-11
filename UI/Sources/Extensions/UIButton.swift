//
//  UIButton.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit

extension UIButton {
    convenience init(
        _ titleText: String? = nil,
        _ titleFont: UIFont = .subtitle,
        _ titleColor: UIColor = .base
    ) {
        self.init(frame: .zero)

        setTitle(titleText, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = titleFont
    }

    convenience init(
        _ image: UIImage? = nil,
        _ tintColor: UIColor = .base,
        isHidden: Bool = false
    ) {
        self.init(frame: .zero)

        setImage(image, for: .normal)
        self.tintColor = tintColor
        self.isHidden = isHidden
    }
}
