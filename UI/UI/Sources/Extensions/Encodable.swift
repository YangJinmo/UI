//
//  Encodable.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
