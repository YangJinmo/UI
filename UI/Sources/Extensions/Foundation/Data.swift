//
//  Data.swift
//  UI
//
//  Created by Jmy on 2022/01/01.
//

import Foundation.NSData
import UIKit

extension Data {
    var toString: String? {
        return String(data: self, encoding: .utf8)
    }

    var toBase64: String {
        return base64EncodedString(options: .endLineWithLineFeed)
    }

    func decodeJSON<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }

    func decodeJSON<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let result = try decodeJSON() as T

            DispatchQueue.main.async {
                completion(.success(result))
            }

        } catch {
            completion(.failure(error))
        }
    }

    func decodeJSONArray<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            let result = try decodeJSON() as [T]

            DispatchQueue.main.async {
                completion(.success(result))
            }

        } catch {
            completion(.failure(error))
        }
    }
}
