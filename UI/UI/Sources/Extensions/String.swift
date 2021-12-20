//
//  String.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import UIKit

extension String {
    var encode: String? {
        var allowedQueryParamAndKey: CharacterSet = .urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
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

    func dateForamt(_ format: String = "yyyy-MM-dd HH:mm:ss.s") -> String {
        let getDateFormatter: DateFormatter = DateFormatter()
        getDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.s"

        let updateDateFormatter: DateFormatter = DateFormatter()
        updateDateFormatter.dateFormat = format
        updateDateFormatter.amSymbol = "오전"
        updateDateFormatter.pmSymbol = "오후"

        guard let date: Date = getDateFormatter.date(from: self) else { return self }
        return updateDateFormatter.string(from: date)
    }
}
