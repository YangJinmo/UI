//
//  FileManager.swift
//  UI
//
//  Created by Jmy on 2022/07/21.
//

import Foundation

extension FileManager {
    class func save(_ data: Data, savePath: String) -> Error? {
        if FileManager.default.fileExists(atPath: savePath) {
            do {
                try FileManager.default.removeItem(atPath: savePath)
            } catch {
                return error
            }
        }
        do {
            try data.write(to: URL(fileURLWithPath: savePath))
        } catch {
            return error
        }
        return nil
    }

    class func save(content: String, savePath: String) -> Error? {
        if FileManager.default.fileExists(atPath: savePath) {
            do {
                try FileManager.default.removeItem(atPath: savePath)
            } catch {
                return error
            }
        }
        do {
            try content.write(to: URL(fileURLWithPath: savePath), atomically: true, encoding: .utf8)
        } catch {
            return error
        }
        return nil
    }

    @discardableResult
    class func create(at path: String) -> Error? {
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error: \(error.localizedDescription)")
                return error
            }
        }
        return nil
    }

    @discardableResult
    class func delete(at path: String) -> Error? {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                return error
            }
            return nil
        }
        return NSError(domain: "File does not exist", code: -1, userInfo: nil) as Error
    }

    class func rename(oldFileName: String, newFileName: String) -> Bool {
        do {
            try FileManager.default.moveItem(atPath: oldFileName, toPath: newFileName)
            return true
        } catch {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }

    class func copy(oldFileName: String, newFileName: String) -> Bool {
        do {
            try FileManager.default.copyItem(atPath: oldFileName, toPath: newFileName)
            return true
        } catch {
            return false
        }
    }

    class var document: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    class var library: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    }

    class var temp: String {
        return NSTemporaryDirectory()
    }

    class var caches: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }

    class var log: String {
        return document.appendingPathComponent("Logs")
    }
}
