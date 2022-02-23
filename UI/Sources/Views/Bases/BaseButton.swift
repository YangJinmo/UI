//
//  BaseButton.swift
//  UI
//
//  Created by Jmy on 2022/02/13.
//

import UIKit

class BaseButton: UIButton {
    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func initialize() {
    }
}
