//
//  ChevronDownButton.swift
//  UI
//
//  Created by Jmy on 2022/08/01.
//

import UIKit

final class ChevronDownButton: BaseButton {

    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected
                ? .base
                : .white(226)

            backgroundColor = isSelected
                ? .secondaryLabel
                : .clear
        }
    }

    override func commonInit() {
        setTitleColor(.white(102), for: .normal)
        setTitleColor(.base, for: .selected)

        setImage(Image.chevronDown, for: .normal)
        setImage(Image.chevronUp, for: .selected)

        titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        semanticContentAttribute = .forceRightToLeft
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)

        layer.borderColor = .white(226)
        layer.borderWidth = 1
        layer.cornerRadius = 16
    }

    func setSelectedTitle(numberOf: Int) {
        guard let title = title(for: .normal) else {
            print("title is nil")
            return
        }

        setTitle("\(title) \(numberOf)", for: .selected)
    }

    func update(numberOf: Int) {
        isSelected = numberOf > 0
        setSelectedTitle(numberOf: numberOf)
    }
}
