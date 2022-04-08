//
//  CollectionLayout.swift
//  UI
//
//  Created by JMY on 2022/04/08.
//

import UIKit

@objc protocol CollectionLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional
    func collectionView(_ collectionView: UICollectionView, firstSectionMaxY maxY: CGFloat)
}

final class CollectionLayout: UICollectionViewLayout {
    weak var delegate: CollectionLayoutDelegate!

    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 8.0

    fileprivate var headerCache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentCache = [UICollectionViewLayoutAttributes]()

    public var contentHeight: CGFloat = 0.0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }

        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    init(delegate: CollectionLayoutDelegate) {
        self.delegate = delegate

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        contentCache.removeAll()
        headerCache.removeAll()
        contentHeight = 0

        guard let collectionView = collectionView else {
            return
        }

        for section in 0 ..< collectionView.numberOfSections {
            let columnWidth = contentWidth / CGFloat(numberOfColumns) - cellPadding
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth + cellPadding)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: contentHeight, count: numberOfColumns)

            let headerSize = delegate?.collectionView(collectionView, heightForHeaderInSection: section) ?? 0.0
            let headerAttributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                with: IndexPath(item: 0, section: section)
            )

            headerAttributes.frame = CGRect(
                x: 0,
                y: contentHeight + (cellPadding / 2),
                width: collectionView.frame.size.width,
                height: headerSize
            )
            contentHeight += headerSize
            headerCache.append(headerAttributes)

            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)

                let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
                let height = cellPadding * 2 + photoHeight

                let frame = CGRect(
                    x: xOffset[column],
                    y: yOffset[column] + headerSize,
                    width: columnWidth,
                    height: height
                )
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                contentCache.append(attributes)

                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height

                column = yOffset[0] > yOffset[1] ? 1 : 0
            }

            if section == 0 {
                delegate.collectionView?(collectionView, firstSectionMaxY: contentHeight)
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)

        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        for attributes in headerCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }

        for attributes in contentCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }

        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)

        return headerCache[indexPath.item]
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)

        return headerCache[indexPath.section]
    }
}
