//
//  Double.swift
//  UI
//
//  Created by Jmy on 2022/11/29.
//

import Foundation

extension Double {
    var km: Double { return self * 1000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1000.0 }
    var ft: Double { return self / 3.28084 }

    func floorNumber(numberOfPlaces: Double = 2.0) -> Double {
        let multiplier = pow(10.0, numberOfPlaces)
        let floored = floor(self * multiplier) / multiplier
        return floored
    }
}
