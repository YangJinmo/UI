//
//  BaseImageView.swift
//  UI
//
//  Created by Jmy on 2021/12/03.
//

import UIKit

class BaseImageView: UIImageView {
    // MARK: - Initialization
    
    convenience override init(image: UIImage?) {
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
    
    var constraint: Constraint? {
        didSet {
            if oldValue != nil {
                removeConstraint(oldValue!)
            }
            if constraint != nil {
                addConstraint(constraint!)
            }
        }
    }
    
    func remakeAspectRatioConstraint(_ image: UIImage) {
        constraint = getAspectRatioConstraint(image)
    }
}
