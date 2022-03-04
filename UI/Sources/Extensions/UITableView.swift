//
//  UITableView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

extension UITableView {
    // MARK: - Reload Completion

    func reloadData(completion: @escaping () -> Void) {
        reloadData()
        performBatchUpdates {
            completion()
        }
    }

    func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .fade, completion: @escaping () -> Void) {
        reloadRows(at: indexPaths, with: animation)
        performBatchUpdates {
            completion()
        }
    }

    // MARK: - UITableViewCell

    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.identifier)
    }

    func registerNib<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)

        register(nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.identifier)")
        }
        return cell
    }

    // MARK: - UITableViewHeaderFooterView

    func register<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: T.identifier)
    }

    func registerNib<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifier, bundle: bundle)

        register(nib, forHeaderFooterViewReuseIdentifier: T.identifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.identifier)")
        }
        return view
    }
}
