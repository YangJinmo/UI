//
//  Double.swift
//  UI
//
//  Created by Jmy on 2022/11/29.
//

import Foundation

extension Double {
    func floorNumber(numberOfPlaces: Double = 2.0) -> Double {
        let multiplier = pow(10.0, numberOfPlaces)
        let floored = floor(self * multiplier) / multiplier
        return floored
    }
}
