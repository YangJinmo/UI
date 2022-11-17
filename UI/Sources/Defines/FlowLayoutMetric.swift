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

    /// width 값은 계산하고
    /// height 값은 직접 입력
    func itemSize(in collectionView: UICollectionView, height: CGFloat = 0) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let width = (collectionWidth - (minimumInteritemSpacing * (numberOfItemForRow - 1))) / numberOfItemForRow

//        "width: \(width), height: \(height)".log()

        return CGSize(width: width, height: height)
    }

    /// width 값은 계산하고
    /// height 값은 width x aspectRatio + addHeight
    func itemSize(in collectionView: UICollectionView, aspectRatio: CGFloat = 1, addHeight: CGFloat = 0) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let width = (collectionWidth - (minimumInteritemSpacing * (numberOfItemForRow - 1))) / numberOfItemForRow
        let height = width * aspectRatio + addHeight

//        "width: \(width), height: \(height)".log()

        return CGSize(width: width, height: height)
    }

    /// row와 column을 입력하여 width 값과 height 값을 계산
    func itemSize(in collectionView: UICollectionView, numberOfItemForColumn: CGFloat) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let verticalInset = sectionInset.top + sectionInset.bottom
        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let collectionHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height - verticalInset
        let width = collectionWidth / numberOfItemForRow
        let height = collectionHeight / numberOfItemForColumn

//        "width: \(width), height: \(height)".log()

        return CGSize(width: width, height: height)
    }
}
