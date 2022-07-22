//
//  SpaceView.swift
//  UI
//
//  Created by Jmy on 2022/07/22.
//

import UIKit

final class SpaceView: BaseView {
    private var height: CGFloat = 16

    init(height: CGFloat = 16) {
        self.height = height

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false

        Constraint.activate([
            heightAnchor.constraint(equalToConstant: height),
        ])
    }
}
