//
//  TableSectionHeaderView.swift
//  UI
//
//  Created by JMY on 2022/03/30.
//

import UIKit

final class TableSectionHeaderView: UITableViewHeaderFooterView {
    // MARK: - Properties

    static let itemHeight: CGFloat = 36

    // MARK: - Views

    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .white(57)
        label.text = "Site"
        label.lineSpacing()
        return label
    }()

    // MARK: - View Life Cycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        /// Fixed so that the background color does not change when the header is sticky
        backgroundView = UIView(frame: bounds)
        backgroundView?.backgroundColor = .systemBlue

        addBottomBorder()

        add(
            explainLabel,
            top: topAnchor,
            left: leftAnchor, 16,
            bottom: bottomAnchor
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
