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

    var url: URL? {
        return URL(string: self)
    }

    func open() {
        guard let url = url else { return }
        url.open()
    }

    func log(function: String = #function, _ value: Any = "", _ comment: String = "") {
        print("func \(function) \(comment)\(self)")
    }
}
