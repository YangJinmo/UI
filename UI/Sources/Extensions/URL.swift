//
//  URL.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import UIKit

extension URL {
    var request: URLRequest {
        return URLRequest(url: self)
    }

    // MARK: - UIApplication

    var canOpenURL: Bool {
        return UIApplication.shared.canOpenURL(self)
    }

    func open() {
        UIApplication.shared.open(self)
    }
}
