//
//  StickyLayout.swift
//  UI
//
//  Created by Jmy on 2023/02/02.
//

import UIKit.UICollectionViewFlowLayout

final class StickyLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()

        sectionFootersPinToVisibleBounds = true
        sectionHeadersPinToVisibleBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        sectionFootersPinToVisibleBounds = true
        sectionHeadersPinToVisibleBounds = true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        for attribute in attributes {
            adjustAttributesIfNeeded(attribute)
        }
        return attributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        adjustAttributesIfNeeded(attributes)
        return attributes
    }

    func adjustAttributesIfNeeded(_ attributes: UICollectionViewLayoutAttributes) {
        switch attributes.representedElementKind {
        case UICollectionView.elementKindSectionHeader?:
            adjustHeaderAttributesIfNeeded(attributes)
        case UICollectionView.elementKindSectionFooter?:
            adjustFooterAttributesIfNeeded(attributes)
        default:
            break
        }
    }

    private func adjustHeaderAttributesIfNeeded(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        guard attributes.indexPath.section == 0 else { return }

        if collectionView.contentOffset.y < 0 {
            attributes.frame.origin.y = collectionView.contentOffset.y
        }
    }

    private func adjustFooterAttributesIfNeeded(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        guard attributes.indexPath.section == collectionView.numberOfSections - 1 else { return }

        if collectionView.contentOffset.y + collectionView.bounds.size.height > collectionView.contentSize.height {
            attributes.frame.origin.y = collectionView.contentOffset.y + collectionView.bounds.size.height - attributes.frame.size.height
        }
    }
}
