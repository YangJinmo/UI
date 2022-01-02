//
//  BaseRefreshControl.swift
//  UI
//
//  Created by Jmy on 2021/11/16.
//

import UIKit

class BaseRefreshControl: UIRefreshControl {
    // MARK: - Initialization

    override convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        tintColor = .tint
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
