//
//  BaseImageView.swift
//  UI
//
//  Created by Jmy on 2021/12/03.
//

import UIKit

class BaseImageView: UIImageView {
    // MARK: - Initialization

    override convenience init(image: UIImage?) {
        self.init(frame: .zero)

        self.image = image
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Variables

    private var aspectRatioConstraint: Constraint? {
        didSet {
            if oldValue != nil {
                removeConstraint(oldValue!)
            }
            if aspectRatioConstraint != nil {
                addConstraint(aspectRatioConstraint!)
            }
        }
    }

    // MARK: - Methods

    func remakeAspectRatioConstraint(_ image: UIImage) {
        aspectRatioConstraint = getAspectRatioConstraint(image)
    }
}
