//
//  LosslessStringConvertible.swift
//  UI
//
//  Created by Jmy on 2023/01/13.
//

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension Numeric where Self: LosslessStringConvertible {
    /**
     ```
     let integer = 123
     let integerDigits = integer.digits // [1, 2, 3]

     let double = 12.34
     let doubleDigits = double.digits // [1, 2, 3, 4]
     ```

     # Link: https://stackoverflow.com/questions/30415937/how-to-split-an-int-to-its-individual-digits
     */
    var digits: [Int] { string.digits }
}
