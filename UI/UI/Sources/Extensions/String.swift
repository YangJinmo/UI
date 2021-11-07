//
//  String.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import Foundation

extension String {
    var encode: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    var url: URL? {
        guard let url: URL = URL(string: self) else {
            log()
            return nil
        }
        return url
    }
    
    func open() {
        guard let url: URL = encode.url else { return }
        url.open()
    }
    
    func log(function: String = #function, _ value: Any = "", _ comment: String = "") {
        print("func \(function) \(comment)\(self)")
    }
}
