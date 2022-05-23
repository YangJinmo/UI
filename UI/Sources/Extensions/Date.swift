//
//  Date.swift
//  UI
//
//  Created by Jmy on 2022/05/23.
//

import Foundation.NSDate

extension Date {
    func toString(dateFormat: String = "yyyy.MM.dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
