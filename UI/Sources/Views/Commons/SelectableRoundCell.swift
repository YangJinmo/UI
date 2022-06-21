//
//  SelectableRoundCell.swift
//  UI
//
//  Created by Jmy on 2022/03/19.
//

import UIKit

final class SelectableRoundCell: BaseCollectionViewCell {
    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .white : .black
            containerView.backgroundColor = isSelected ? .tint : .white(241)
        }
    }

    private let height: CGFloat = 34.0

    // MARK: - Views

    private lazy var containerView = UIView()
    private lazy var titleLabel = UILabel.subtitle()

    // MARK: - View Life Cycle

    override func commonInit() {
        contentView.add(
            containerView,
            heightConstant: height,
            edges: contentView
        )

        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = height / 2.0

        containerView.add(
            titleLabel,
            left: containerView.leftAnchor, 20,
            right: containerView.rightAnchor, -20,
            center: containerView
        )

        isSelected = false
    }

    // MARK: - Methods

    func setTitleLabel(text: String?) {
        titleLabel.text = text
    }
}
