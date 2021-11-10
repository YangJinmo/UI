//
//  SearchTermCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTermCell: BaseCollectionViewCell {
    // MARK: - Views

    private let rankLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        return label
    }()

    // MARK: - Initialization

    override func setupViews() {
        contentView.addSubviews(
            rankLabel,
            titleLabel
        )

        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: rankLabel.rightAnchor, constant: 20),
        ])
    }

    // MARK: - Internal Methods

    func bind(rank: Int, term: String) {
        rankLabel.text = "\(rank)"
        titleLabel.text = term
    }
}
