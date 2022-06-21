//
//  SearchTermCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class SearchTermCell: BaseCollectionViewCell {
    // MARK: - Constants

    static let itemHeight: CGFloat = 44.0

    // MARK: - Views

    private lazy var rankTermLabel = UILabel.subtitle()

    // MARK: - Methods

    override func commonInit() {
        contentView.add(
            rankTermLabel,
            center: contentView
        )
    }

    func bind(rank: Int, term: String) {
        rankTermLabel.text = "\(rank). \(term)"
    }
}
