//
//  Date.swift
//  UI
//
//  Created by Jmy on 2022/05/23.
//

import Foundation.NSDate

extension Date {
    func toString(dateFormat: String = "yyyy.MM.dd HH:mm:ss:SSS") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current // TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current // Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    var year: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.year], from: self)

            guard let year = components.year else {
                return 0
            }

            return year
        }
        set {
            update(components: [.year: newValue])
        }
    }

    var month: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.month], from: self)

            guard let month = components.month else {
                return 0
            }

            return month
        }
        set {
            update(components: [.month: newValue])
        }
    }

    var day: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.day], from: self)

            guard let day = components.day else {
                return 0
            }

            return day
        }
        set {
            update(components: [.day: newValue])
        }
    }

    var hour: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.hour], from: self)

            guard let hour = components.hour else {
                return 0
            }

            return hour
        }
        set {
            update(components: [.hour: newValue])
        }
    }

    var minute: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.minute], from: self)

            guard let minute = components.minute else {
                return 0
            }

            return minute
        }
        set {
            update(components: [.minute: newValue])
        }
    }

    var second: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.second], from: self)

            guard let second = components.second else {
                return 0
            }

            return second
        }
        set {
            update(components: [.second: newValue])
        }
    }

    var nanosecond: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.nanosecond], from: self)

        guard let nanosecond = components.nanosecond else {
            return 0
        }

        return nanosecond
    }

    /// - 1 - Sunday.
    /// - 2 - Monday.
    /// - 3 - Tuerday.
    /// - 4 - Wednesday.
    /// - 5 - Thursday.
    /// - 6 - Friday.
    /// - 7 - Saturday.
    var weekday: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.weekday], from: self)

        guard let weekday = components.weekday else {
            return 0
        }

        return weekday
    }

    enum EditableDateComponents: Int {
        case year
        case month
        case day
        case hour
        case minute
        case second
    }

    mutating func update(components: [EditableDateComponents: Int]) {
        let autoupdatingCalendar = Calendar.autoupdatingCurrent
        var dateComponents = autoupdatingCalendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second, .nanosecond], from: self)

        for (component, value) in components {
            switch component {
            case .year:
                dateComponents.year = value
            case .month:
                dateComponents.month = value
            case .day:
                dateComponents.day = value
            case .hour:
                dateComponents.hour = value
            case .minute:
                dateComponents.minute = value
            case .second:
                dateComponents.second = value
            }
        }

        let calendar = Calendar(identifier: autoupdatingCalendar.identifier)
        guard let date = calendar.date(from: dateComponents) else {
            return
        }

        self = date
    }

    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second

        let calendar = Calendar.autoupdatingCurrent
        guard let date = calendar.date(from: components) else {
            return nil
        }
        self = date
    }

    func description(dateSeparator: String = "/", usFormat: Bool = false, nanosecond: Bool = false) -> String {
        var description: String

        #if os(Linux)
            if usFormat {
                description = String(format: "%04li-%02li-%02li %02li:%02li:%02li", year, month, day, hour, minute, second)
            } else {
                description = String(format: "%02li-%02li-%04li %02li:%02li:%02li", month, day, year, hour, minute, second)
            }
        #else
            if usFormat {
                description = String(format: "%04li%@%02li%@%02li %02li:%02li:%02li", year, dateSeparator, month, dateSeparator, day, hour, minute, second)
            } else {
                description = String(format: "%02li%@%02li%@%04li %02li:%02li:%02li", month, dateSeparator, day, dateSeparator, year, hour, minute, second)
            }
        #endif

        if nanosecond {
            description += String(format: ":%03li", self.nanosecond / 1000000)
        }
        return description
    }

    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current

        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)

        return abs(components.day ?? 0)
    }
}
