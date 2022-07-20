//
//  String.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import UIKit

extension String {
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }

    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }

    init(floatTypeNumber: Float) {
        self = "\(floatTypeNumber)"
    }

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

    // MARK: - Regular Expression

    func regexFirstString(_ pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
            if let _ = regex.firstMatch(in: self, options: .anchored, range: NSRange(location: 0, length: 1)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }

    func regex(_ pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .allowCommentsAndWhitespace)
            if let _ = regex.firstMatch(in: self, options: .reportCompletion, range: NSMakeRange(0, count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }

    // 천지인 키보드의 ‘·(middle dot)’ 허용을 위해서 추가된 코드
    var hasCharacters: Bool {
        regex("^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\u318D\\u119E\\u11A2\\u2022\\u2025\\u00B7\\uFE55\\u4E10\\u3163\\u3161\\s]$")
    }

    var hasNumber: Bool {
        regex("^[0-9]$")
    }

    var isEmail: Bool {
        let regEx = "[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,100}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)

        return predicate.evaluate(with: self)
    }

    var isBackspace: Bool {
        let utf8Char: [CChar]? = cString(using: .utf8)
        let backspace: Int32 = strcmp(utf8Char, "\\b")
        return backspace == -92
    }

    var hasPhoneNumber: Bool {
        return hasPrefix("010") ? count == 11 : regex("^01(?:0|1|[6-9])(?:\\d{7}|\\d{8})$")
    }

    var containsWhitespace: Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }

    var removeWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }

    func toPhoneNumber() -> String {
        return replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: " $1-$2-$3", options: .regularExpression, range: nil)
    }

    func toHiddenPhoneNumber() -> String {
        return replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: " $1-****-$3", options: .regularExpression, range: nil)
    }

    func toHiddenEmail() -> String {
        let stringArr = split(separator: "@")

        if stringArr[0].count > 3 {
            let string = rangeByIndex(start: 0, end: 2)
            let asterisks = String(
                repeating: "*",
                count: stringArr[0].count - 3
            )
            return string + asterisks + "@" + stringArr[1]
        } else {
            return self
        }
    }

    func rangeByIndex(start: Int, end: Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: start)
        let endIndex = index(self.startIndex, offsetBy: end)
        let c = self[startIndex ... endIndex]
        return String(c)
    }

    // MARK: - Size

    private func size(ofFont font: UIFont) -> CGSize {
        return size(withAttributes: [NSAttributedString.Key.font: font])
    }

    func width(ofFont font: UIFont) -> CGFloat {
        return ceil(size(ofFont: font).width)
    }

    func height(ofFont font: UIFont) -> CGFloat {
        return ceil(size(ofFont: font).height)
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

    // MARK: - NSString

    var toNSString: NSString {
        return NSString(string: self)
    }

    /// Appends a path component to the string.
    func appendingPathComponent(_ path: String) -> String {
        let string = NSString(string: self)

        return string.appendingPathComponent(path)
    }

    /// Appends a path extension to the string.
    func appendingPathExtension(_ ext: String) -> String? {
        let nsSt = NSString(string: self)

        return nsSt.appendingPathExtension(ext)
    }

    /// Returns an array of path components.
    var pathComponents: [String] {
        return NSString(string: self).pathComponents
    }

    /// Delete the path extension.
    var deletingPathExtension: String {
        return NSString(string: self).deletingPathExtension
    }

    /// Returns the last path component.
    var lastPathComponent: String {
        return NSString(string: self).lastPathComponent
    }

    /// Returns the path extension.
    var pathExtension: String {
        return NSString(string: self).pathExtension
    }

    /// Delete the last path component.
    var deletingLastPathComponent: String {
        return NSString(string: self).deletingLastPathComponent
    }
}
