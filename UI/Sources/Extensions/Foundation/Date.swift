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

    // MARK: - Unix Timestamp

    /// 1970년 1월 1일 0시(UTC)를 기점으로 현재까지의 경과 시간을 초 단위로 환산하여 나타낸 값입니다.
    /// 예를 들어 2020년 1월 1일 0시(UTC)는 유닉스 시간으로 1577836800으로 표기합니다.
    static var timestamp: Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }

    var milliseconds: Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}
