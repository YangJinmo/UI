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

    func hideEmptyCells() {
        tableFooterView = UIView()
    }

    func resetInsets() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
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

    var indexPaths: [IndexPath] {
        var indexPaths = [IndexPath]()

        for section in 0 ..< numberOfSections {
            for row in 0 ..< numberOfRows(inSection: section) {
                indexPaths.append(IndexPath(row: row, section: section))
            }
        }

        return indexPaths
    }

    var indexPathsForAllRows: [IndexPath] {
        let indexPaths = (0 ..< numberOfSections).compactMap { section -> [IndexPath]? in
            (0 ..< numberOfRows(inSection: section)).compactMap({ row -> IndexPath? in
                IndexPath(row: row, section: section)
            })
        }.flatMap { $0 }

        return indexPaths
    }

    func indexPaths(section: Int) -> [IndexPath] {
        var indexPaths: [IndexPath] = []

        for row in 0 ..< numberOfRows(inSection: section) {
            indexPaths.append(IndexPath(row: row, section: section))
        }

        return indexPaths
    }

    func nextIndexPath(row: Int, forSection section: Int) -> IndexPath? {
        let indexPaths = indexPaths(section: section)

        guard !indexPaths.isEmpty else {
            return nil
        }

        return indexPaths[row + 1]
    }

    func previousIndexPath(row: Int, forSection section: Int) -> IndexPath? {
        let indexPaths = indexPaths(section: section)

        guard !indexPaths.isEmpty else {
            return nil
        }

        return indexPaths[row - 1]
    }

    var lastIndexPath: IndexPath? {
        let numberOfIndexPaths = indexPaths.count

        guard numberOfIndexPaths > 1 else {
            return nil
        }

        return IndexPath(row: numberOfIndexPaths - 1, section: 0)
    }

    // MARK: - Select / Deselect

    func selectForAllRows(animated: Bool = true) {
        indexPathsForAllRows.forEach { indexPath in
            selectRow(at: indexPath, animated: animated, scrollPosition: .none)
        }
    }

    func deselectForAllRows(animated: Bool = true) {
        indexPathsForSelectedRows?.forEach({ indexPath in
            deselectRow(at: indexPath, animated: animated)
        })
    }

    // MARK: - Perform Batch Updates

    /// Allows multiple insert/delete/reload/move calls to be animated simultaneously. Nestable.

    func reloadData(completion: @escaping () -> Void) {
//        UIView.animate(withDuration: 0) {
//            self.reloadData()
//        } completion: { _ in
//            completion()
//        }

        performBatchUpdates {
            reloadData()
        } completion: { _ in
            completion()
        }
    }

    func reloadSections(at sections: IndexSet, with animation: UITableView.RowAnimation = .automatic, completion: @escaping () -> Void) {
        performBatchUpdates {
            reloadSections(sections, with: animation)
        } completion: { _ in
            completion()
        }
    }

    func reloadRows(indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic, completion: @escaping () -> Void) {
        performBatchUpdates {
            reloadRows(at: indexPaths, with: animation)
        } completion: { _ in
            completion()
        }
    }

    func insertRows(indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic, completion: @escaping () -> Void) {
        performBatchUpdates {
            insertRows(at: indexPaths, with: animation)
        } completion: { _ in
            completion()
        }
    }

    func deleteRows(indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic, completion: @escaping () -> Void) {
        performBatchUpdates {
            deleteRows(at: indexPaths, with: animation)
        } completion: { _ in
            completion()
        }
    }

    func insertRowsAtBottom(_ indexPaths: [IndexPath]) {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        beginUpdates()
        insertRows(at: indexPaths, with: .none)
        endUpdates()
        scrollToRow(at: indexPaths[0], at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }

    func scrollBottomWithoutFlashing() {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }

    func scrollBottomToLastRow() {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
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
