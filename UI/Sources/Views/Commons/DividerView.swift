//
//  DividerView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

class DividerView: BaseView {
    // MARK: - Methods

    override func initialize() {
        backgroundColor = .secondarySystemBackground

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
