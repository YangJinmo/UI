//
//  StringProtocol.swift
//  UI
//
//  Created by Jmy on 2022/02/01.
//

extension StringProtocol {
    /**
      ````
      let string = "123456"
      let digits = string.digits // [1, 2, 3, 4, 5, 6]
      ````

     # Link: https://stackoverflow.com/questions/30415937/how-to-split-an-int-to-its-individual-digits
      */
    var digits: [Int] {
        return compactMap(\.wholeNumberValue)
    }

    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }

    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
