//
//  Bundle.swift
//  UI
//
//  Created by Jmy on 2021/12/13.
//

import UIKit

extension Bundle {
    class var appName: String {
        guard
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let value: String = infoDictionary["CFBundleName"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    class var appDisplayName: String {
        guard
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let value: String = infoDictionary["CFBundleDisplayName"] as? String
        else {
            return appName
        }
        return value
    }

    class var appVersion: String {
        guard
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let value: String = infoDictionary["CFBundleShortVersionString"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    class var appBuild: String {
        guard
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let value: String = infoDictionary["CFBundleVersion"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    class var bundle: String {
        guard
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let value: String = infoDictionary["CFBundleIdentifier"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    class var appVersionAndBuild: String {
        return "v\(appVersion) (\(appBuild))"
    }
}
