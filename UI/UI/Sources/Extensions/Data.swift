//
//  Data.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import UIKit

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
