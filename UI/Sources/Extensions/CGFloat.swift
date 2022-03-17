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
}
