//
//  String.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import Foundation

extension String {
    var encode: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    var url: URL? {
        return URL(string: self)
    }

    func open() {
        guard let url: URL = url else { return }
        url.open()
    }

    func log(function: String = #function, _ value: Any = "", _ comment: String = "") {
        print("func \(function) \(comment)\(self)")
    }
}
