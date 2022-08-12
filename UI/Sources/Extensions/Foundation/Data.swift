//
//  Data.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit

extension Data {
    var toString: String? {
        String(data: self, encoding: .utf8)
    }

    var toBase64: String {
        base64EncodedString(options: .endLineWithLineFeed)
    }

    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
