//
//  StringProtocol.swift
//  UI
//
//  Created by Jmy on 2022/02/01.
//

extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }

    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
