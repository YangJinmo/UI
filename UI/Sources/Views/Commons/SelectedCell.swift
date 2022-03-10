//
//  SelectedCell.swift
//  UI
//
//  Created by JMY on 2022/03/08.
//

import UIKit

final class SelectedCell: BaseCollectionViewCell {
    // MARK: - Properties

    static let itemHeight: CGFloat = 44.0

    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .tint : .black
        }
    }

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    // MARK: - View Life Cycle

    override func initialize() {
        contentView.addSubviews(titleLabel)

        Constraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
    }

    // MARK: - Methods

    func setTitleLabel(_ text: String?) {
        titleLabel.text = text
    }
}
