//
//  LeftAlignCollectionViewFlowLayout.swift
//  UI
//
//  Created by Jmy on 2022/11/25.
//

import UIKit

final class LeftAlignCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        minimumLineSpacing = 10.0
        sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}

/// https://fomaios.tistory.com/entry/iOSUI-%EC%BB%AC%EB%A0%89%EC%85%98%EB%B7%B0%EC%85%80-%EC%9E%90%EB%8F%99%EC%9C%BC%EB%A1%9C-%ED%81%AC%EA%B8%B0-%EC%A1%B0%EC%A0%95%ED%95%98%EA%B3%A0-%EC%99%BC%EC%AA%BD-%EC%A0%95%EB%A0%AC%ED%95%98%EA%B8%B0-CollectionViewCell-Automaticsize-LeftAlign
