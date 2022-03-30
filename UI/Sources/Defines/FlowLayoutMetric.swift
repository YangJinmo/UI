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

    func flowLayout() -> UICollectionViewFlowLayout
}

extension FlowLayoutMetric {
    func flowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = sectionInset
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        return flowLayout
    }

    func itemSize(width view: UIView, height: CGFloat) -> CGSize {
        let horizontalInset = sectionInset.left + sectionInset.right
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - horizontalInset, height: height)
    }
}
