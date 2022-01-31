//
//  UIStoryboard.swift
//  UI
//
//  Created by Jmy on 2022/02/01.
//

import UIKit

extension UIStoryboard {
    enum Name: String {
        case main
        case login
        case profile

        var filename: String {
            return rawValue.firstCapitalized
        }
    }

    convenience init(_ storyboard: UIStoryboard.Name, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
}
