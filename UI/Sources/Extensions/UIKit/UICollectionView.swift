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

    func selectAll(animated: Bool = true) {
        (0 ..< numberOfSections).compactMap { section -> [IndexPath]? in
            (0 ..< numberOfItems(inSection: section)).compactMap({ item -> IndexPath? in
                IndexPath(item: item, section: section)
            })
        }.flatMap { $0 }.forEach { indexPath in
            selectItem(at: indexPath, animated: animated, scrollPosition: [])
        }
    }

    func deselectAll(animated: Bool = true) {
        indexPathsForSelectedItems?.forEach({ indexPath in
            deselectItem(at: indexPath, animated: animated)
        })
    }

    // MARK: - Reload Completion

    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0) {
            self.reloadData()
        } completion: { _ in
            completion()
        }
    }

    func reloadItems(indexPath: IndexPath, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0) {
            self.reloadItems(indexPath: indexPath)
        } completion: { _ in
            completion()
        }
    }

    func reloadItems(indexPath: IndexPath) {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.reloadItems(at: [indexPath])
            }
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
