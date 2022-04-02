//
//  BaseCollectionView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

class BaseCollectionView: UICollectionView {
    // MARK: - Initialization

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false

        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func initialize() {
    }
}
