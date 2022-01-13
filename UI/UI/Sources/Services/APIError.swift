//
//  APIError.swift
//  UI
//
//  Created by Jmy on 2022/01/13.
//

import Foundation.NSURL

enum APIError {
    case error(Error)
    case noData
    case noResponse
    case responseCode(Int)
    case parseError
    case message(String)
}

extension APIError: LocalizedError {
    var errorText: String? {
        switch self {
        case .error(let error):
            return "Error: error calling GET: \(error)"
        case .noData:
            return "Error: Did not receive data"
        case .noResponse:
            return "Error: HTTP request failed"
        case .responseCode(let statusCode):
            return "Status code: \(statusCode)"
        case .parseError:
            return "Error: JSON Data Parsing failed"
        case .message(let msg):
            return "Error: \(msg)"
        }
    }
}
