//
//  String.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import UIKit

extension String {
    var encode: String? {
        var allowedQueryParamAndKey: CharacterSet = .urlQueryAllowed // ! $ & \ ( ) * +  - . / : ; = ? @ _ ~
        allowedQueryParamAndKey.insert("#")
        return addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)
    }

    var toURL: URL? {
        return URL(string: self)
    }

    var toURLComponents: URLComponents? {
        return URLComponents(string: self)
    }

    func open() {
        guard let url = toURL else {
            "Error: urlString is URL not Supported \(self)".log()
            return
        }
        url.open()
    }

    func log(function: String = #function, _ value: Any = "", _ comment: String = "") {
        print("func \(function) \(comment)\(self)")
    }
}
