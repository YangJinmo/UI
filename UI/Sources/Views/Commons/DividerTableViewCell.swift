//
//  DividerTableViewCell.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class DividerTableViewCell: BaseTableViewCell {
    // MARK: - Views

    private lazy var dividerView = DividerView()

    // MARK: - Methods

    override func setupViews() {
        contentView.addSubviews(dividerView)

        Constraint.activate([
            dividerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}