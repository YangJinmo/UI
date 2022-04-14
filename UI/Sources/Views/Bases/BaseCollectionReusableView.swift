//
//  BaseCollectionReusableView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func commonInit() {
    }
}
