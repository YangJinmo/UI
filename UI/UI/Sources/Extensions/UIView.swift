//
//  UIView.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

extension UIView {
    
    // MARK: - Methods

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func subviewsTranslatesAutoresizingMaskIntoConstraintsFalse() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
