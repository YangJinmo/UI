//
//  CGSize.swift
//  UI
//
//  Created by Jmy on 2022/12/24.
//

import CoreGraphics.CGGeometry
import UIKit

extension CGSize {
    init(both: CGFloat) {
        self.init(width: both, height: both)
    }

    init(_ width: CGFloat = 0, _ height: CGFloat = 0) {
        self.init(width: width, height: height)
    }

    func toPixel() -> CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: width * scale, height: height * scale)
    }

    // http://stackoverflow.com/a/17948778/3071224

    func aspectFit(boundingSize: CGSize) -> CGSize {
        var boundingSize = boundingSize

        let mW = boundingSize.width / width
        let mH = boundingSize.height / height

        if mH < mW {
            boundingSize.width = mH * width
        } else if mW < mH {
            boundingSize.height = mW * height
        }

        return boundingSize
    }

    func aspectFill(minimumSize: CGSize) -> CGSize {
        var minimumSize = minimumSize

        let mW = minimumSize.width / width
        let mH = minimumSize.height / height

        if mH > mW {
            minimumSize.width = mH * width
        } else if mW > mH {
            minimumSize.height = mW * height
        }

        return minimumSize
    }

    // https://github.com/bugnitude/CGSize-AspectRatio/blob/master/CGSize%2BAspectRatio.swift

    func aspectFit(into boundingSize: CGSize) -> CGSize {
        if width == 0.0 || height == 0.0 {
            return self
        }

        let widthRatio = boundingSize.width / width
        let heightRatio = boundingSize.height / height
        let aspectFitRatio = min(widthRatio, heightRatio)
        return CGSize(width: width * aspectFitRatio, height: height * aspectFitRatio)
    }

    func aspectFill(into minimumSize: CGSize) -> CGSize {
        if width == 0.0 || height == 0.0 {
            return self
        }

        let widthRatio = minimumSize.width / width
        let heightRatio = minimumSize.height / height
        let aspectFillRatio = max(widthRatio, heightRatio)
        return CGSize(width: width * aspectFillRatio, height: height * aspectFillRatio)
    }
}
