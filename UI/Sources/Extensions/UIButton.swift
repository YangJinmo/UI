//
//  UIButton.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit.UIButton

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

    func setImagePosition(_ position: Position, _ cgfloat: CGFloat = 4) {
        let inset = position == .left ? -cgfloat : cgfloat
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: inset)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
        semanticContentAttribute = position.rawValue
    }
}


// MARK: - Image Position

enum Position {
    case left
    case right
}

extension Position: RawRepresentable {
    typealias RawValue = UISemanticContentAttribute

    init?(rawValue: RawValue) {
        switch rawValue {
        case .forceLeftToRight: self = .left
        case .forceRightToLeft: self = .right
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .left: return .forceLeftToRight
        case .right: return .forceRightToLeft
        }
    }
}
