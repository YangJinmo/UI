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

    var height: CGFloat = 34.0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = height / 2.0

            heightConstraint.constant = height
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

    override func initialize() {
        titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)

        addConstraint(heightConstraint)
        height = 34.0
    }

    convenience init(_ text: String?, isSelected: Bool = false) {
        self.init(frame: .zero)

        setTitle(text, for: .normal)
        self.isSelected = isSelected
    }
}
