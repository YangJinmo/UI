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

    func log(function: String = #function, _ comment: String = "") {
        print("func \(function) \(comment)\(self)")
    }

    func toDate(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self) ?? Date()
    }

    // MARK: - NSAttributedString

    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.foregroundColor: color])
    }

    func background(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.backgroundColor: color])
    }

    func underline(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: style.rawValue])
    }

    func underlineColor(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineColor: color])
    }

    func font(_ font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font: font])
    }

    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.shadow: shadow])
    }

    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
}
