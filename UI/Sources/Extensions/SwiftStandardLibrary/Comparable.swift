//
//  Comparable.swift
//  UI
//
//  Created by Jmy on 2023/02/07.
//

extension Comparable {
    /**
     ```
     let number1 = 5
     print(number1.clamp(low: 0, high: 10))
     print(number1.clamp(low: 0, high: 3))
     print(number1.clamp(low: 6, high: 10))

     let number2 = 5.0
     print(number2.clamp(low: 0, high: 10))
     print(number2.clamp(low: 0, high: 3))
     print(number2.clamp(low: 6, high: 10))

     let letter1 = "r"
     print(letter1.clamp(low: "a", high: "f"))
     ```
     */
    func clamp(low: Self, high: Self) -> Self {
        if self > high {
            return high
        } else if self < low {
            return low
        }

        return self
    }
}
