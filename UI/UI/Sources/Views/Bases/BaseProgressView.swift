//
//  BaseProgressView.swift
//  UI
//
//  Created by Jmy on 2021/11/08.
//

import UIKit

class BaseProgressView: UIProgressView {
    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        progressViewStyle = .bar
        progressTintColor = .tint
        trackTintColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
