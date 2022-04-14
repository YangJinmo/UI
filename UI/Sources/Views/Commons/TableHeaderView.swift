//
//  TableHeaderView.swift
//  UI
//
//  Created by JMY on 2022/03/30.
//

import UIKit

final class TableHeaderView: BaseView {
    // MARK: - Views

    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.textColor = .white(57)
        label.text = "안녕하세요!\nzzimss입니다."
        label.spaceBetweenTheLines()
        return label
    }()

    // MARK: - View Life Cycle

    override func commonInit() {
        backgroundColor = .secondarySystemBackground

        add(
            explainLabel,
            top: topAnchor, 16,
            left: leftAnchor, 16,
            bottom: bottomAnchor, 16
        )
    }
}
