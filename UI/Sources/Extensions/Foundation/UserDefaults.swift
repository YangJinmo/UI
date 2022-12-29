//
//  UserDefaults.swift
//  UI
//
//  Created by JMY on 2022/05/31.
//

import Foundation.NSUserDefaults

extension UserDefaults {
    static func save(at value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func get(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    static func isExist(forKey key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    func save(at value: Any?, forKey key: String) {
        set(value, forKey: key)
        synchronize()
    }

    func remove(forKey key: String) {
        removeObject(forKey: key)
        synchronize()
    }

    func get(forKey key: String) -> Any? {
        return object(forKey: key)
    }

    func isExist(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
