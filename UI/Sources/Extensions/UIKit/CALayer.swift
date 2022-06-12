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

    func addBorder(color: UIColor, width: CGFloat) {
        borderColor = color.cgColor
        borderWidth = width
    }

    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        layoutIfNeeded()

        for edge in edges {
            let layer = CALayer()
            layer.name = edge.rawValue.description
            layer.backgroundColor = color.cgColor

            switch edge {
            case .top:
                layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
                break

            case .left:
                layer.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
                break

            case .bottom:
                layer.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
                break

            case .right:
                layer.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
                break

            case .all:
                addBorder(color: color, width: width)
                return

            default:
                break
            }

            addSublayer(layer)
        }
    }

    func removeBorder(_ edges: [UIRectEdge]) {
        guard let sublayers = sublayers else {
            return
        }

        var layerForRemove: CALayer?

        for edge in edges {
            for layer in sublayers {
                if layer.name == edge.rawValue.description {
                    layerForRemove = layer
                }
            }
        }

        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
}
