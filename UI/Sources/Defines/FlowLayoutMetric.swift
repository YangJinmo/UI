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

    /// collectionView의 width가 이미 정해져 있는 경우,
    /// item의 width 값은 계산, height 값은 직접 입력
    func itemSize(in collectionView: UICollectionView, height itemHeight: CGFloat = 0) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let totalLineSpacing = minimumLineSpacing * (numberOfItemForRow - 1)

        let itemWidth = (collectionWidth - totalLineSpacing) / numberOfItemForRow

//        "width: \(itemWidth), height: \(itemHeight)".log()

        return CGSize(width: itemWidth, height: itemHeight)
    }

    /// collectionView의 width가 이미 정해져 있는 경우,
    /// item의 width 값은 계산, height 값은 width x aspectRatio(이미지 비율) + addHeight(하단 텍스트)
    func itemSize(in collectionView: UICollectionView, aspectRatio: CGFloat = 1, addHeight: CGFloat = 0) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let totalLineSpacing = minimumLineSpacing * (numberOfItemForRow - 1)

        let itemWidth = (collectionWidth - totalLineSpacing) / numberOfItemForRow
        let itemHeight = itemWidth * aspectRatio + addHeight

//        "width: \(itemWidth), height: \(itemHeight)".log()

        return CGSize(width: itemWidth, height: itemHeight)
    }

    /// collectionView의 width와 height가 이미 정해져 있는 경우,
    /// row와 column을 입력하여 item의 width 값과 height 값을 계산
    func itemSize(in collectionView: UICollectionView, numberOfItemForColumn: CGFloat) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        let verticalInset = sectionInset.top + sectionInset.bottom

        let collectionWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - horizontalInset
        let collectionHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height - verticalInset

        let totalLineSpacing = minimumLineSpacing * (numberOfItemForRow - 1)
        let totalInteritemSpacing = minimumInteritemSpacing * (numberOfItemForColumn - 1)

        let itemWidth = (collectionWidth - totalLineSpacing) / numberOfItemForRow
        let itemHeight = (collectionHeight - totalInteritemSpacing) / numberOfItemForColumn

//        "width: \(itemWidth), height: \(itemHeight)".log()

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
