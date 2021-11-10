//
//  BaseWebView.swift
//  UI
//
//  Created by Jmy on 2021/11/08.
//

import UIKit
import WebKit

class BaseWebView: WKWebView {
    // MARK: - Initialization

    convenience init(configuration: WKWebViewConfiguration) {
        self.init(frame: .zero, configuration: configuration)
    }

    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)

        allowsBackForwardNavigationGestures = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
