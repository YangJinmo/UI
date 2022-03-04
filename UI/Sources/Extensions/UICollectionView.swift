//
//  UICollectionView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

extension UICollectionView {
    // MARK: - Reload Completion

    func reloadData(completion: @escaping () -> Void) {
        reloadData()
        performBatchUpdates {
            completion()
        }
    }

    func reloadItems(at indexPaths: [IndexPath], completion: @escaping () -> Void) {
        reloadItems(at: indexPaths)
        performBatchUpdates {
            completion()
        }
    }

    // MARK: - UICollectionViewCell

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

    // MARK: - UICollectionReusableView

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
