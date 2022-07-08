//
//  TapSlider.swift
//  UI
//
//  Created by Jmy on 2022/07/08.
//

import UIKit.UISlider

final class TapSlider: UISlider {
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let width = frame.size.width
//        let tapPoint = touch.location(in: self)
//        let fPercent = tapPoint.x / width
//        let nNewValue = maximumValue * Float(fPercent)
//
//        if nNewValue != value {
//            value = nNewValue
//        }
//        return true
//    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let tapPoint = touch.location(in: self)
        let fraction = Float(tapPoint.x / bounds.width)
        let newValue = (maximumValue - minimumValue) * fraction + minimumValue

        if newValue != value {
            value = newValue
            sendActions(for: .valueChanged)
        }

        return true
    }

//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        super.beginTracking(touch, with: event)
//        print(touch.location(in: self))
//        return true
//    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        print(touch.location(in: self))
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        print(touch?.location(in: self) ?? 0)
    }
}
