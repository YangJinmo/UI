//
//  UITableView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

public protocol ReusableView {
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
}

extension UITableViewHeaderFooterView: ReusableView {
}

extension UITableView {
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

    // MARK: - UITableViewCell

    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(_: T.Type) {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: bundle)

        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    // MARK: - UITableViewHeaderFooterView

    func register<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: bundle)

        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}
