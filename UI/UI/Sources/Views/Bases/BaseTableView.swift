//
//  BaseTableView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class BaseTableView: UITableView {
    // MARK: - Initialization

    convenience init(style: UITableView.Style = .plain) {
        self.init(frame: .zero, style: style)
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        separatorStyle = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
