//
//  UIImage.swift
//  UI
//
//  Created by Jmy on 2021/12/03.
//

import UIKit.UIImage

extension UIImage {
    static let chevronLeft = UIImage(systemName: "chevron.left")
    static let xmark = UIImage(systemName: "xmark")

    static let chevronUp = UIImage(systemName: "chevron.up")
    static let chevronDown = UIImage(systemName: "chevron.down")

    static let arrowUp = UIImage(systemName: "arrow.up")
    static let arrowLeft = UIImage(systemName: "arrow.left")
}

extension UIImage {
    convenience init(bundleName: StaticString) {
        self.init(named: "\(bundleName)")!
    }

    var ratio: CGFloat {
        size.width / size.height
    }

    class func createThumbImage(size: CGFloat, borderWidth: CGFloat, fillColor: UIColor, strokeColor: UIColor) -> UIImage? {
        let layerFrame = CGRect(x: 0, y: 0, width: size, height: size)
        let path = UIBezierPath(
            arcCenter: CGPoint(x: layerFrame.midX, y: layerFrame.midY),
            radius: size / 2,
            startAngle: -90.degreesToRadians,
            endAngle: 270.degreesToRadians,
            clockwise: true
        ).cgPath

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0

        let layer = CALayer()
        layer.frame = layerFrame
        layer.cornerRadius = size / 2
        layer.borderWidth = borderWidth
        layer.borderColor = strokeColor.cgColor
        layer.masksToBounds = true
        layer.addSublayer(shapeLayer)
        return imageFromLayer(layer: layer)
    }

    class func imageFromLayer(layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
}
