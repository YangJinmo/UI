//
//  URL.swift
//  UI
//
//  Created by Jmy on 2021/11/07.
//

import UIKit

extension URL {
    var request: URLRequest {
        URLRequest(url: self)
    }
    
    func log() {
        absoluteString.log()
    }
    
    func canOpenURL() -> Bool {
        UIApplication.shared.canOpenURL(self)
    }
    
    func open() {
        UIApplication.shared.open(self)
    }
}
