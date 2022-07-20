//
//  Log.swift
//  UI
//
//  Created by Jmy on 2022/07/20.
//

import Foundation

struct Log {
    // MARK: - Enum

    private enum LogType {
        case warning, error, debug, info

        var level: String {
            switch self {
            case .error:
                return "❌ ERROR"
            case .warning:
                return "⚠️ WARNING"
            case .info:
                return "💙 INFO"
            case .debug:
                return "💚 DEBUG"
            }
        }
    }

    // MARK: - Properties

    /// Activate or not
    static var active: Bool = isDebug

    /// The log string.
    static var logged: String = ""

    /// The detailed log string.
    static var detailedLog: String = ""

    // MARK: - Private Methods

    private static func log(_ items: [Any], filename: String = #file, function: StaticString = #function, line: Int = #line, type: LogType) {
        if active {
            var _message = type.level + " " + message(from: items)
            if _message.hasSuffix("\n") == false {
                _message += "\n"
            }

            logged += _message

            let filenameWithoutExtension = filename.lastPathComponent.deletingPathExtension
            let timestamp = Date().description(dateSeparator: "-", usFormat: true, nanosecond: true)
            let logMessage = "\(timestamp) \(filenameWithoutExtension):\(line) \(function): \(_message)"
            print(logMessage, terminator: "")

            detailedLog += logMessage
        }
    }

    private static func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }

    // MARK: - Static Methods

    static func warning(_ items: Any..., filename: String = #file, function: StaticString = #function, line: Int = #line) {
        log(items, filename: filename, function: function, line: line, type: .warning)
    }

    static func error(_ items: Any..., filename: String = #file, function: StaticString = #function, line: Int = #line) {
        log(items, filename: filename, function: function, line: line, type: .error)
    }

    static func debug(_ items: Any..., filename: String = #file, function: StaticString = #function, line: Int = #line) {
        log(items, filename: filename, function: function, line: line, type: .debug)
    }

    static func info(_ items: Any..., filename: String = #file, function: StaticString = #function, line: Int = #line) {
        log(items, filename: filename, function: function, line: line, type: .info)
    }

    /// Clear the log string.
    static func clear() {
        logged = ""
        detailedLog = ""
    }

    /// Save the Log in a file.
    static func saveLog(
        in path: String = FileManager.log,
        filename: String = Date().toString(dateFormat: "yyyy-MM-dd").appendingPathExtension("log")!
    ) {
        if detailedLog.isEmpty { return }
        let fullPath = path.appendingPathComponent(filename)
        var logs = detailedLog
        if FileManager.default.fileExists(atPath: fullPath) {
            logs = try! String(contentsOfFile: fullPath, encoding: .utf8)
            logs = logs + detailedLog
            _ = FileManager.save(content: logs, savePath: path.appendingPathComponent(filename))
            return
        }
        FileManager.create(at: fullPath)
        _ = FileManager.save(content: logs, savePath: fullPath)
    }
}
