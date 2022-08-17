//
//  WKWebView.swift
//  UI
//
//  Created by Jmy on 2021/11/08.
//

import WebKit.WKWebView

extension WKWebView {
    // MARK: - Cookies

    func removeAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

    func refreshCookies() {
        configuration.processPool = WKProcessPool()
    }

    func deleteAuthenticationCookies() {
        configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.name == "authentication" {
                    /// Delete authentication cookies
                    self.configuration.websiteDataStore.httpCookieStore.delete(cookie)
                } else {
                    /// Print cookies
                    print("\(cookie.name) is set to \(cookie.value)")
                }
            }
        }
    }

    func takeSnapshot(rect: CGRect = CGRect(x: 0, y: 0, width: 150, height: 50)) {
        let config = WKSnapshotConfiguration()
        config.rect = rect

        takeSnapshot(with: config) { image, _ in
            if let image = image {
                print(image.size)
            }
        }
    }

    func backList() {
        for page in backForwardList.backList {
            print("User visited \(page.url.absoluteString)")
        }
    }
}
