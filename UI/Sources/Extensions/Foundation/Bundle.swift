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
        return main.infoDictionary?["CFBundleName"] as? String ?? "Unknown"
    }

    static var appDisplayName: String {
        return main.infoDictionary?["CFBundleDisplayName"] as? String ?? appName
    }

    static var appVersion: String {
        return main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    static var appBuild: String {
        return main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    static var identifier: String {
        return main.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }

    static var appVersionAndBuild: String {
        return "v\(appVersion) (\(appBuild))"
    }

    static var iconFilePath: String {
        let iconFilename = main.object(forInfoDictionaryKey: "CFBundleIconFile") as! NSString
        let iconBasename = iconFilename.deletingPathExtension
        let iconExtension = iconFilename.pathExtension
        return main.path(forResource: iconBasename, ofType: iconExtension)!
    }

    static var iconImage: UIImage? {
        return UIImage(contentsOfFile: iconFilePath)
    }

    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }

        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }

        let decoder = JSONDecoder()

        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode \(filename) from app bundle.")
        }

        return result
    }
}
