//
//  UserDefaults.swift
//  UI
//
//  Created by JMY on 2022/05/31.
//

import Foundation

extension UserDefaults {
    func isExist(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
