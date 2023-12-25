//
//  Double.swift
//  UI
//
//  Created by Jmy on 2022/11/29.
//

import Foundation

extension Double {
    var absoluteValue: Double {
        return abs(self)
    }

    /**
     ```
     let oneInch = 25.4.mm
     print("One inch is \(oneInch) meters")
     // Prints "One inch is 0.0254 meters"

     let threeFeet = 3.ft
     print("Three feet is \(threeFeet) meters")
     // Prints "Three feet is 0.914399970739201 meters"

     let aMarathon = 42.km + 195.m
     print("A marathon is \(aMarathon) meters long")
     // Prints "A marathon is 42195.0 meters long"
     */

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

    var toDecimal: String {
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .decimal
        return numberformatter.string(for: self) ?? ""
    }
}
