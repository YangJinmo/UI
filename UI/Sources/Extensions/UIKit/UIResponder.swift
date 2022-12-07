//
//  UIResponder.swift
//  UI
//
//  Created by Jmy on 2022/12/06.
//

import UIKit.UIResponder

extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return next.flatMap({ $0 as? U ?? $0.next() })
    }
}

//extension UITableViewCell {
//    var tableView: UITableView? {
//        return next(of: UITableView.self)
//    }
//}
