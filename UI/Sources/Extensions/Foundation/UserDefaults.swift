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

    static func get(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func isExist(forKey key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    func isExist(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
