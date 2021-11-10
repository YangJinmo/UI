//
//  FlowLayoutMetric.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

protocol FlowLayoutMetric {
    var numberOfItemForRow: CGFloat { get }
    var inset: CGFloat { get }
    var lineSpacing: CGFloat { get }
    var interItemSpacing: CGFloat { get }

    func flowLayout() -> UICollectionViewFlowLayout
}

extension FlowLayoutMetric {
    func flowLayout() -> UICollectionViewFlowLayout {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(horizontal: inset, vertical: 0)
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.minimumInteritemSpacing = interItemSpacing
        return flowLayout
    }

    func itemSize(width view: UIView, height: CGFloat) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - (inset * 2), height: height)
    }
}
