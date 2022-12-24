//
//  CGSize.swift
//  UI
//
//  Created by Jmy on 2022/12/24.
//

import CoreGraphics.CGGeometry

extension CGSize {
    init(both: CGFloat) {
        self.init(width: both, height: both)
    }

    init(_ width: CGFloat = 0, _ height: CGFloat = 0) {
        self.init(width: width, height: height)
    }
}
