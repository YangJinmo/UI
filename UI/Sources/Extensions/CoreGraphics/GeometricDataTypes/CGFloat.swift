//
//  CGFloat.swift
//  UI
//
//  Created by Jmy on 2022/01/03.
//

import CoreGraphics.CGGeometry

extension CGFloat {
    /// 근사값 찾기
    func nearest(inValues values: [CGFloat]) -> CGFloat {
        guard let nearestValue = values.min(by: { abs(self - $0) < abs(self - $1) }) else {
            return self
        }
        return nearestValue
    }

    var randomFloat: CGFloat {
        CGFloat(drand48())
    }
}
