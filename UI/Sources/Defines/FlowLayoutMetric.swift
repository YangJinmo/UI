//
//  FlowLayoutMetric.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

protocol FlowLayoutMetric {
    var numberOfItemForRow: CGFloat { get }
    var sectionInset: UIEdgeInsets { get }
    var minimumLineSpacing: CGFloat { get }
    var minimumInteritemSpacing: CGFloat { get }

    func flowLayout(
        _ scrollDirection: UICollectionView.ScrollDirection
//        numberOfItemForRow: CGFloat,
//        sectionInset: UIEdgeInsets,
//        minimumLineSpacing: CGFloat,
//        minimumInteritemSpacing: CGFloat
    ) -> UICollectionViewFlowLayout
}

extension FlowLayoutMetric {
    func flowLayout(
        _ scrollDirection: UICollectionView.ScrollDirection = .vertical
//        numberOfItemForRow: CGFloat = 1.0,
//        sectionInset: UIEdgeInsets = .uniform(size: 0.0),
//        minimumLineSpacing: CGFloat = 1.0,
//        minimumInteritemSpacing: CGFloat = 0.0
    ) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scrollDirection
        flowLayout.sectionInset = sectionInset
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        return flowLayout
    }

    func itemSize(width view: UIView, height: CGFloat) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let collectionWidth = view.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let width = (collectionWidth - (minimumInteritemSpacing * (numberOfItemForRow - 1))) / numberOfItemForRow
        return CGSize(width: width, height: height)
    }
}
