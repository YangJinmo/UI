//
//  CALayer.swift
//  UI
//
//  Created by Jmy on 2022/05/08.
//

import UIKit

extension CALayer {
    func setShadow(
        x: CGFloat,
        y: CGFloat,
        blur: CGFloat,
        alpha: Float
    ) {
        masksToBounds = false
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur
        shadowColor = UIColor.black.cgColor
        shadowOpacity = alpha
    }
}
