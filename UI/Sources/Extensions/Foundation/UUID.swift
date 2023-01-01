//
//  UUID.swift
//  UI
//
//  Created by Jmy on 2022/12/31.
//

import Foundation.NSUUID

extension UUID {
    static var string: String {
        return Foundation.UUID().uuidString // .replacingOccurrences(of: "-", with: "")
    }
}
