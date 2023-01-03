//
//  UICollectionViewCell.swift
//  UI
//
//  Created by Jmy on 2023/01/03.
//

import UIKit.UICollectionViewCell

extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return superview as? UICollectionView
    }

    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }
}
