//
//  UICollectionView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit.UICollectionView

extension UICollectionView {
    convenience init(layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }

    func sectionWidth(at section: Int) -> CGFloat {
        var width = bounds.width
        width -= contentInset.left
        width -= contentInset.right

        if let delegate = delegate as? UICollectionViewDelegateFlowLayout,
           let inset = delegate.collectionView?(self, layout: collectionViewLayout, insetForSectionAt: section) {
            width -= inset.left
            width -= inset.right
        } else if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            width -= layout.sectionInset.left
            width -= layout.sectionInset.right
        }

        return width
    }

    var indexPaths: [IndexPath] {
        var indexPaths = [IndexPath]()

        for section in 0 ..< numberOfSections {
            for item in 0 ..< numberOfItems(inSection: section) {
                indexPaths.append(IndexPath(item: item, section: section))
            }
        }

        return indexPaths
    }

    var indexPathsForAllItems: [IndexPath] {
        let indexPaths = (0 ..< numberOfSections).compactMap { section -> [IndexPath]? in
            (0 ..< numberOfItems(inSection: section)).compactMap({ item -> IndexPath? in
                IndexPath(item: item, section: section)
            })
        }.flatMap { $0 }

        return indexPaths
    }

    func nextIndexPath(to indexPath: IndexPath, offset: Int = 0) -> IndexPath? {
        return UICollectionView.nextIndexPath(to: indexPath, offset: offset, source: indexPaths)
    }

    func previousIndexPath(to indexPath: IndexPath, offset: Int = 0) -> IndexPath? {
        return UICollectionView.nextIndexPath(to: indexPath, offset: offset, source: indexPaths.reversed())
    }

    private class func nextIndexPath(to indexPath: IndexPath, offset: Int = 0, source: [IndexPath]) -> IndexPath? {
        var found = false
        var skippedResults = offset

        for currentIndexPath in source {
            if found {
                if skippedResults <= 0 {
                    return currentIndexPath
                }

                skippedResults -= 1
            }

            if currentIndexPath == indexPath {
                found = true
            }
        }

        return nil
    }

    // MARK: - Scroll

    // For Horizontal Scrolling: .left
    // For Vertical Scrolling - .top
    func scrollToFirst(at scrollPosition: UICollectionView.ScrollPosition = .top, animated: Bool = true) {
        let indexPath = IndexPath(item: 0, section: 0)
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }

    // For Horizontal Scrolling: .right
    // For Vertical Scrolling - .bottom
    func scrollToLast(at scrollPosition: UICollectionView.ScrollPosition = .bottom, animated: Bool = true) {
        guard numberOfSections > 0 else {
            return
        }

        let lastSection = numberOfSections - 1

        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }

        let lastItem = numberOfItems(inSection: lastSection) - 1
        let indexPath = IndexPath(item: lastItem, section: lastSection)

        // For Horizontal Scrolling: .right
        // For Vertical Scrolling - .bottom
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }

    // MARK: - Select / Deselect

    func selectForAllItems(animated: Bool = true) {
        indexPathsForAllItems.forEach { indexPath in
            selectItem(at: indexPath, animated: animated, scrollPosition: [])
        }
    }

    func deselectForAllItems(animated: Bool = true) {
        indexPathsForSelectedItems?.forEach { indexPath in
            deselectItem(at: indexPath, animated: animated)
        }
    }

    // MARK: - Background View

    func setBackgroundView() {
        backgroundView = {
            let view = UIView(
                frame: CGRect(
                    x: self.center.x,
                    y: self.center.y,
                    width: self.bounds.width,
                    height: self.bounds.height
                )
            )
            view.backgroundColor = backgroundColor
            return view
        }()
    }

    func restoreBackgroundView() {
        backgroundView = nil
    }

    // MARK: - Register UICollectionViewCell

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.identifier)")
        }
        return cell
    }

    // MARK: - Register UICollectionReusableView

    func register<T: UICollectionReusableView>(_ viewClass: T.Type, kind: SupplementaryViewKind) {
        register(viewClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.identifier)
    }

    func registerHeader<T: UICollectionReusableView>(_ viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
    }

    func registerFooter<T: UICollectionReusableView>(_ viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionReusableView>(_ viewClass: T.Type, kind: SupplementaryViewKind) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.identifier)
    }

    func registerHeaderNib<T: UICollectionReusableView>(_ viewClass: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
    }

    func registerFooterNib<T: UICollectionReusableView>(_ viewClass: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
    }

    func dequeueReusableViewHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.identifier)")
        }
        return cell
    }

    func dequeueReusableViewFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.identifier)")
        }
        return cell
    }
}
