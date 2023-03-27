//
//  URL.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import Foundation.NSURL
import UIKit.UIApplication

extension URL {
    var toURLRequest: URLRequest {
        return URLRequest(url: self)
    }

    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return nil
        }

        var parameters = [String: String]()

        for item in queryItems {
            parameters[item.name] = item.value
        }

        return parameters
    }

    // MARK: - UIApplication

    var canOpenURL: Bool {
//        return UIApplication.shared.canOpenURL(self)
        guard UIApplication.shared.canOpenURL(self) else {
            "Error: URL that cannot be opened \(self)".log()
            return false
        }

        return true
    }

    func open() {
//        UIApplication.shared.open(self)
        UIApplication.shared.open(self) { success in
            "Open \(self): \(success)".log()
        }
    }

    func toData() throws -> Data {
        return try Data(contentsOf: self, options: .mappedIfSafe)
    }

    func toData(completion: @escaping (Data) -> Void) {
        do {
            let data = try toData()

            DispatchQueue.main.async {
                completion(data)
            }

        } catch {
            error.localizedDescription.log()
        }
    }

    func toData(completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let data = try toData()

            DispatchQueue.main.async {
                completion(.success(data))
            }

        } catch {
            completion(.failure(error))
        }
    }
}
