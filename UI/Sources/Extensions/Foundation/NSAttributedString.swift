//
//  NSAttributedString.swift
//  UI
//
//  Created by JMY on 2022/02/15.
//

import Foundation.NSAttributedString
import UIKit

extension NSAttributedString {
    func apply(_ attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: string, attributes: self.attributes(at: 0, effectiveRange: nil))
        mutable.addAttributes(attributes, range: NSMakeRange(0, (string as NSString).length))
        return mutable
    }

    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        return apply([.foregroundColor: color])
    }

    func background(_ color: UIColor) -> NSAttributedString {
        return apply([.backgroundColor: color])
    }

    func underline(style: NSUnderlineStyle = .single) -> NSAttributedString {
        return apply([.underlineStyle: style.rawValue])
    }

    func underlineColor(_ color: UIColor) -> NSAttributedString {
        return apply([.underlineColor: color])
    }

    func font(_ font: UIFont) -> NSAttributedString {
        return apply([.font: font])
    }

    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        return apply([.shadow: shadow])
    }
}
