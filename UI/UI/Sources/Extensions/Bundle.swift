//
//  Bundle.swift
//  UI
//
//  Created by Jmy on 2021/12/13.
//

import UIKit

extension Bundle {
    static var appName: String {
        guard
            let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary["CFBundleName"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    static var appDisplayName: String {
        guard
            let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary["CFBundleDisplayName"] as? String
        else {
            return appName
        }
        return value
    }

    static var appVersion: String {
        guard
            let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary["CFBundleShortVersionString"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    static var appBuild: String {
        guard
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let value = infoDictionary["CFBundleVersion"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    static var bundle: String {
        guard
            let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary["CFBundleIdentifier"] as? String
        else {
            return "Unknown"
        }
        return value
    }

    static var appVersionAndBuild: String {
        return "v\(appVersion) (\(appBuild))"
    }
}
