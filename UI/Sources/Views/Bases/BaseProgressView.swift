//
//  BaseProgressView.swift
//  UI
//
//  Created by Jmy on 2021/11/08.
//

import UIKit

final class BaseProgressView: UIProgressView {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        progressViewStyle = .bar
        progressTintColor = .tint
        trackTintColor = .clear

//        transform = CGAffineTransform(scaleX: 1, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
