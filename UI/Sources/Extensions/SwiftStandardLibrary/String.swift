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

    // MARK: - Log

    var source: String {
        let components = components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!.components(separatedBy: ".").first!
    }

    func log(filename: String = #file, line: Int = #line, function: String = #function, _ comment: String = "") {
        print("\(Date().toString()) [\(filename.source):\(line)] \(function) \(comment)\(self)")
    }

    // MARK: - Localized

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    // MARK: - Date

    func toDate(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self) ?? Date()
    }

    // MARK: - URL

    var encode: String? {
        var allowedQueryParamAndKey: CharacterSet = .urlQueryAllowed // ! $ & \ ( ) * +  - . / : ; = ? @ _ ~
        allowedQueryParamAndKey.insert("#")
        return addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)
    }

    var toURLComponents: URLComponents? {
        return URLComponents(string: self)
    }

    var toBundleURL: URL? {
        return Bundle.main.url(forResource: self, withExtension: nil)
    }

    var toURL: URL? {
//        return URL(string: self)
        guard !isEmpty else {
            "Error: urlString is empty".log()
            return nil
        }

        guard let url = URL(string: self) else {
            "Error: urlString is URL not Supported \(self)".log()
            return nil
        }

        return url
    }

    func open() {
        guard let url = toURL else {
            return
        }

        guard url.canOpenURL else {
            return
        }

        url.open()
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

    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: utf16.count)) ?? 0
    }

    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == utf16.count
        } else {
            return false
        }
    }

    // 천지인 키보드의 ‘·(middle dot)’ 허용을 위해서 추가된 코드
    var hasCharacters: Bool {
        regex("^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\u318D\\u119E\\u11A2\\u2022\\u2025\\u00B7\\uFE55\\u4E10\\u3163\\u3161\\s]$")
    }

    var hasNumber: Bool {
        regex("^[0-9]$")
    }

    var hasPhoneNumber: Bool {
        return hasPrefix("010") ? count == 11 : regex("^01(?:0|1|[6-9])(?:\\d{7}|\\d{8})$")
    }

    var isEmail: Bool {
        let regEx = "[0-9a-zA-Z._%+-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,100}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    var isNumber: Bool {
        let characterSet = CharacterSet(charactersIn: "0123456789")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }

    var isSpecialCharacter: Bool {
        let characterSet = CharacterSet(charactersIn: "@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/" + "")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }

    var isBackspace: Bool {
        let utf8Char: [CChar]? = cString(using: .utf8)
        let backspace: Int32 = strcmp(utf8Char, "\\b")
        return backspace == -92
    }

    var containsWhitespace: Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }

    var removeWhitespaces: String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }

    var trimmingWhitespaces: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }

        return returnValue
    }

    var toPhoneNumber: String {
        return replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: " $1-$2-$3", options: .regularExpression, range: nil)
    }

    var toHiddenPhoneNumber: String {
        return replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: " $1-****-$3", options: .regularExpression, range: nil)
    }

    var toHiddenEmail: String {
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

    /**
     ```
     let testString = "He thrusts his fists against the posts and still insists he sees the ghosts."
     print(testString.truncate(to: 20, addEllipsis: true))
     // Prints: He thrusts his fists...
     ```
     */

    func truncate(to length: Int, addEllipsis: Bool = false) -> String {
        if length > count { return self }

        let endPosition = index(startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]

        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }

    // 특정 범위의 문자는 문자열[범위]로 가능하다.

    // 첫번째 문자.
    var start: String {
        let c: Character = self[startIndex]
        return String(c)
    }

    // 마지막 문자.
    var end: String {
        let endIndex: Index = index(before: self.endIndex)
        let c: Character = self[endIndex]
        return String(c)
    }

    // 특정 문자의 위치 없는경우 nil 반환 여러개면 맨 처음 검색되는 문자열만 반환.
    func indexLocation(char: String) -> Int? {
        if let charRange: Range<String.Index> = range(of: char) {
            let location: Int = distance(from: startIndex, to: charRange.lowerBound)
            return location
        }
        return nil
    }

    // 현재 문자열에서 찾는 문자까지의 범위. 찾는 문자가 없으면 nil
    func rangeOfString(char: String) -> ClosedRange<String.Index>? {
        let startIndex = self.startIndex
        guard let findIndex = indexLocation(char: char) else {
            return nil
        }
        let endIndex = index(startIndex, offsetBy: findIndex)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // 현재 문자열에서 찾는 문자 전까지의 범위. 찾는 문자가 없으면 nil
    func preRangeOfString(char: String) -> ClosedRange<String.Index>? {
        let startIndex = self.startIndex
        guard let findIndex = indexLocation(char: char) else {
            return nil
        }
        let endIndex = index(startIndex, offsetBy: findIndex - 1)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // 현재 문자열에서 찾는 문자 전까지의 범위. 찾는 문자가 없으면 nil
    func postRangeOfString(char: String) -> ClosedRange<String.Index>? {
        guard let findIndex = indexLocation(char: char) else {
            return nil
        }
        let startIndex = index(self.startIndex, offsetBy: findIndex + 1)
        let endIndex = index(before: self.endIndex)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // a문자부터 b문자까지의 범위
    func rangeOfString(aChar: String, bChar: String) -> ClosedRange<String.Index>? {
        guard let findA = indexLocation(char: aChar) else {
            return nil
        }
        let startIndex = index(self.startIndex, offsetBy: findA)

        guard let findB = indexLocation(char: bChar) else {
            return nil
        }
        let endIndex = index(self.startIndex, offsetBy: findB)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // 특정 위치의 문자
    func rangeOfDistance(a: Int, b: Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: a)
        let endIndex = index(self.startIndex, offsetBy: b)
        let c = self[startIndex ... endIndex]
        return String(c)
    }

    // 특정 문자의 위치를 갖고있는 배열을 반환

    // self에서 특정 문자의 범위를 찾는다
    // 특정 문자의 범위로 특정 문자를 찾는다.
    func indexLocations(char: String) -> [Int] {
        let strArr = Array(self)
        let result = strArr.enumerated().filter { (arg: (offset: Int, element: String.Element)) -> Bool in
            String(arg.element) == char
        }.compactMap { (index: Int, _: String.Element) -> Int in
            index
        }
        return result
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

    func width(withHeight constrainedHeight: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: constrainedHeight)
        let boundingBox = (self as NSString).boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }

    func height(withWidth constrainedWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: constrainedWidth, height: .greatestFiniteMagnitude)
        let boundingBox = (self as NSString).boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    // MARK: - Color

//    var color = "#d3d3d3".toUIColor
//    var color = "d3d3d3".toUIColor
//    var color = "d3d3d3".toUIColor.withAlphaComponent(0.5)
    var toUIColor: UIColor {
        var cString: String = trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.removeFirst()
        }

        /// wrong hex
        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    var toCGColor: CGColor {
        return toUIColor.cgColor
    }

    // MARK: - NSAttributedString

    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.foregroundColor: color])
    }

    func background(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.backgroundColor: color])
    }

    func strikethrough(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: style.rawValue])
    }

    func underline(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: style.rawValue])
    }

    func underlineColor(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineColor: color])
    }

    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.shadow: shadow])
    }

    func font(_ font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font: font])
    }

    func italic() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
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
