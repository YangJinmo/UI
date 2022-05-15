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

    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in edges {
            let border = CALayer()

            switch edge {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
                break

            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
                break

            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
                break

            case .right:
                border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
                break

            default:
                break
            }

            border.backgroundColor = color.cgColor

            addSublayer(border)
        }
    }
}
