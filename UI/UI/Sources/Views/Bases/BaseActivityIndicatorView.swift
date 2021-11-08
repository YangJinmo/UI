//
//  BaseActivityIndicatorView.swift
//  UI
//
//  Created by Jmy on 2021/11/08.
//

import UIKit

class BaseActivityIndicatorView: UIActivityIndicatorView {
    // MARK: - Initialization

    override init(style: UIActivityIndicatorView.Style = .medium) {
        super.init(style: style)

        hidesWhenStopped = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
