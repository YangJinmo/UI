//
//  Identifiable.swift
//  UI
//
//  Created by Jmy on 2022/01/30.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable {
}

extension UITableViewHeaderFooterView: Identifiable {
}

extension UICollectionReusableView: Identifiable {
}
