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

    private let rankTermLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    // MARK: - Methods

    override func setupViews() {
        contentView.add(
            rankTermLabel,
            center: contentView
        )
    }

    func bind(rank: Int, term: String) {
        rankTermLabel.text = "\(rank). \(term)"
    }
}
