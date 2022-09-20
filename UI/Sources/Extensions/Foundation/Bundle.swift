//
//  Bundle.swift
//  UI
//
//  Created by Jmy on 2021/12/13.
//

import Foundation.NSBundle
import UIKit.UIImage

extension Bundle {
    static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Unknown"
    }

    static var appDisplayName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? appName
    }

    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    static var appBuild: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    static var bundle: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }

    static var appVersionAndBuild: String {
        return "v\(appVersion) (\(appBuild))"
    }

    static var iconFilePath: String {
        let iconFilename = Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFile") as! NSString
        let iconBasename = iconFilename.deletingPathExtension
        let iconExtension = iconFilename.pathExtension
        return Bundle.main.path(forResource: iconBasename, ofType: iconExtension)!
    }

    static var iconImage: UIImage? {
        return UIImage(contentsOfFile: iconFilePath)
    }
}
