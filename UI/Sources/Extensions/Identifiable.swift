//
//  Identifiable.swift
//  UI
//
//  Created by Jmy on 2022/01/30.
//

import UIKit

protocol ViewIdentifiable {
}

extension ViewIdentifiable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ViewIdentifiable {
}

extension UITableViewHeaderFooterView: ViewIdentifiable {
}

extension UICollectionReusableView: ViewIdentifiable {
}
