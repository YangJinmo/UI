//
//  CGFloat.swift
//  UI
//
//  Created by Jmy on 2022/01/03.
//

import CoreGraphics

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

    /// 근사값 찾기
    func nearest(inValues values: [CGFloat]) -> CGFloat {
        guard let nearestValue = values.min(by: { abs(self - $0) < abs(self - $1) }) else {
            return self
        }
        return nearestValue
    }
}
