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

    func resizeImage(targetSize: CGSize) -> UIImage? {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize

        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    func resize(_ size: CGSize, contentMode: UIView.ContentMode = .scaleToFill, quality: CGInterpolationQuality = .medium) -> UIImage? {
        let horizontalRatio = size.width / self.size.width
        let verticalRatio = size.height / self.size.height
        var ratio: CGFloat!

        switch contentMode {
        case .scaleToFill:
            ratio = 1
        case .scaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .scaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        default:
            ratio = 1
        }

        let rect = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height * ratio)

        // Fix for a colorspace / transparency issue that affects some types of
        // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        let transform = CGAffineTransform.identity

        // Rotate and/or flip the image if required by its orientation
        context?.concatenate(transform)

        // Set the quality level to use when rescaling
        context!.interpolationQuality = quality

        // CGContextSetInterpolationQuality(context, CGInterpolationQuality(kCGInterpolationHigh.value))

        // Draw into the context; this scales the image
        context?.draw(cgImage!, in: rect)

        // Get the resized image from the context and a UIImage
        let newImage = UIImage(cgImage: (context?.makeImage()!)!, scale: scale, orientation: imageOrientation)
        return newImage
    }
}
