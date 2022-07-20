//
//  Log.swift
//  UI
//
//  Created by Jmy on 2022/07/20.
//

struct Log {
    // MARK: - Variables

    private enum LogType {
        case warning, error, debug, info

        var level: String {
            switch self {
            case .error: return "❌ ERROR"
            case .warning: return "⚠️ WARNING"
            case .info: return "💙 INFO"
            case .debug: return "💚 DEBUG"
            }
        }
    }
}
