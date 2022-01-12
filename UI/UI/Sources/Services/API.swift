//
//  API.swift
//  UI
//
//  Created by Jmy on 2022/01/12.
//

enum API {
    case issues(String, String)
}

extension API {
    static let baseURL = "https://api.github.com"

    var path: String {
        switch self {
        case let .issues(owner, repo):
            return API.baseURL + "/repos/\(owner)/\(repo)/issues"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .issues:
            return .GET
        }
    }
}
