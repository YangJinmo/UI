//
//  BaseView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

class BaseView: UIView {
    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Methods

    func commonInit() {
    }
}
