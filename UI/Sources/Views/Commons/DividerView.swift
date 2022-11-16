//
//  DividerView.swift
//  UI
//
//  Created by JMY on 2022/03/22.
//

import UIKit

final class DividerView: BaseView {
    override func commonInit() {
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1).isActive = true

        guard let superview = superview else {
            return
        }

        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
}
