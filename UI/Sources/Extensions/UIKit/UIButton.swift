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

    var normalTitle: String {
        get {
            return title(for: .normal) ?? ""
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    var selectedTitle: String {
        get {
            return title(for: .selected) ?? ""
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }

    var normalTitleColor: UIColor {
        get {
            return titleColor(for: .normal) ?? .white
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    var selectedTitleColor: UIColor {
        get {
            return titleColor(for: .selected) ?? .white
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    var normalImage: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    var selectedImage: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    var fontSize: CGFloat {
        get {
            return titleLabel?.font.pointSize ?? 17
        }
        set {
            titleLabel?.font = UIFont.systemFont(ofSize: newValue)
        }
    }

    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let size = CGSize(width: 1, height: 1)
        let rectangle = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rectangle)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        setBackgroundImage(image!, for: state)
    }
}
