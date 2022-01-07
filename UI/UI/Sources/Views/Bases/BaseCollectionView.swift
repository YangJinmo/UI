//
//  BaseCollectionView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class BaseCollectionView: UICollectionView {
    // MARK: - Initialization

    convenience init(layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
