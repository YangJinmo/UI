//
//  SelectableButton.swift
//  UI
//
//  Created by Jmy on 2022/03/07.
//

import UIKit

final class SelectableButton: BaseButton {
    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .tint : .white(241)
            setTitleColor(isSelected ? .white : .black, for: .normal)
        }
    }

    var height: CGFloat? {
        didSet {
            guard let height = height else {
                return
            }

            layer.masksToBounds = true
            layer.cornerRadius = height / 2.0

            heightConstraint.constant = height
        }
    }

    var font: UIFont? {
        didSet {
            titleLabel?.font = font
        }
    }

    // MARK: - Views

    private lazy var heightConstraint = NSLayoutConstraint(
        item: self,
        attribute: .height,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1,
        constant: 34
    )

    // MARK: - Initialization

    override func commonInit() {
        addConstraint(heightConstraint)
        height = 34.0
        font = .systemFont(ofSize: 15, weight: .regular)
    }

    convenience init(_ text: String?, isSelected: Bool = false) {
        self.init(frame: .zero)

        setTitle(text, for: .normal)
        self.isSelected = isSelected
    }
}
