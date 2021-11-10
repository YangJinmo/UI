//
//  UICollectionView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    // MARK: - UICollectionViewCell

    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    // MARK: - UICollectionReusableView

    func register<T: UICollectionReusableView>(_ viewClass: T.Type, kind: SupplementaryViewKind) {
        register(viewClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerHeader<T: UICollectionReusableView>(_ viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerFooter<T: UICollectionReusableView>(_ viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UICollectionReusableView>(_ viewClass: T.Type, kind: SupplementaryViewKind) {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerHeaderNib<T: UICollectionReusableView>(_ viewClass: T.Type) {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerFooterNib<T: UICollectionReusableView>(_ viewClass: T.Type) {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: bundle)

        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableViewHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableViewFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
