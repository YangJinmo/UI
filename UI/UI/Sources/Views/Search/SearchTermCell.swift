//
//  SearchTermCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTermCell: BaseCollectionViewCell {
    // MARK: - Variables

    static var itemHeight: CGFloat {
        return 44
    }

    // MARK: - Views

    private let rankLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    // MARK: - Methods

    override func setupViews() {
        contentView.add(
            subview: rankLabel,
            center: contentView
        )
    }

    func bind(rank: Int, term: String) {
        rankLabel.text = "\(rank). \(term)"
    }
}
