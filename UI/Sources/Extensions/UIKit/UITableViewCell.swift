//
//  UITableViewCell.swift
//  UI
//
//  Created by Jmy on 2022/12/06.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    var tableView: UITableView? {
        return superview as? UITableView
    }

    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}
