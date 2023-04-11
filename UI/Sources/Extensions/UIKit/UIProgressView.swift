//
//  UIProgressView.swift
//  UI
//
//  Created by Jmy on 2023/04/11.
//

import UIKit.UIProgressView

extension UIProgressView {
    static func bar() -> UIProgressView {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = UIColor.tint
        progressView.trackTintColor = .clear
        return progressView
    }
}
