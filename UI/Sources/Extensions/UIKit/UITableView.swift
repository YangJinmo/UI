//
//  UITableView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit.UITableView

extension UITableView {
    convenience init(style: UITableView.Style = .plain) {
        self.init(frame: .zero, style: style)
    }

    // MARK: - tableHeaderView, tableFooterView sizeToFit

    var optimalSizeTableHeaderView: UIView? {
        set {
            tableHeaderView = newValue

            guard let header = newValue else {
                return
            }

            header.setNeedsLayout()
            header.layoutIfNeeded()
            header.frame.size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            tableHeaderView = header
        }
        get {
            return tableHeaderView
        }
    }

    // MARK: - Select / Deselect

    func selectAll(animated: Bool = true) {
        (0 ..< numberOfSections).compactMap { section -> [IndexPath]? in
            (0 ..< numberOfRows(inSection: section)).compactMap({ item -> IndexPath? in
                IndexPath(item: item, section: section)
            })
        }.flatMap { $0 }.forEach { indexPath in
            selectRow(at: indexPath, animated: animated, scrollPosition: .none)
        }
    }

    func deselectAll(animated: Bool = true) {
        indexPathsForSelectedRows?.forEach({ indexPath in
            deselectRow(at: indexPath, animated: animated)
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

    func reloadRows(indexPath: IndexPath, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0) {
            self.reloadRows(indexPath: indexPath)
        } completion: { _ in
            completion()
        }
    }

    func reloadRows(indexPath: IndexPath, with animation: UITableView.RowAnimation = .none) {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.reloadRows(at: [indexPath], with: animation)
            }
        }
    }

    func deleteRows(at: [IndexPath], with: UITableView.RowAnimation = .fade, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0) {
            self.deleteRows(at: at, with: with)
        } completion: { _ in
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
