//
//  IndicatorCollectionReusableView.swift
//  UI
//
//  Created by Jmy on 2022/03/18.
//

import UIKit

final class IndicatorCollectionReusableView: BaseCollectionReusableView {
    // MARK: - Properties

    static let itemHeight: CGFloat = 50.0

    // MARK: - Views

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    // MARK: - View Life Cycle

    override func initialize() {
        add(
            activityIndicatorView,
            center: self
        )
    }
}
