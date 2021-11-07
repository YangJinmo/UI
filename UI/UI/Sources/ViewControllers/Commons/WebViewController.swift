//
//  WebViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/06.
//

import UIKit
import WebKit

final class WebViewController: BaseNavigationViewController {
    
    // MARK: - Constants
    
    private let scriptMessageHandler: String = "scriptHandler"
    
    var urlString: String?
    var isShowTitleView: Bool = true
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    // MARK: - Views
    
    private var webView: WKWebView!
    private var ai: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWebView()
        setupWebView()
        removeCache()
        loadWebView()
    }
    
    // MARK: - Methods
    
    private func setWebView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: scriptMessageHandler)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: view.frame, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
    }
    
    private func setupWebView() {
        view.addSubviews(webView)
        
        view.subviewsTranslatesAutoresizingMaskIntoConstraintsFalse()
        
        let webViewTopAnchor = isShowTitleView ? titleView.bottomAnchor : view.safeAreaLayoutGuide.topAnchor
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: webViewTopAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadWebView() {
        guard let urlString: String = urlString else { return }
        webView.load(urlString: urlString)
    }
    
    private func removeCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
    
    var passMessage: ((String) -> ())?
    
    private func passMessage(_ message: String) {
        if let pm: ((String) -> ()) = passMessage {
            pm(message)
            popViewController()
        }
    }
}

// MARK: - WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler
extension WebViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if (message.name == scriptMessageHandler) {
            passMessage(message.body as! String)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: {action in completionHandler()})
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {(action) in completionHandler(false)})
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: {(action) in completionHandler(true)})
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ai = UIActivityIndicatorView(style: .medium)
        ai.frame = CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25, width: 50, height: 50)
        ai.hidesWhenStopped = true
        ai.startAnimating()
        view.addSubview(ai)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url: URL = navigationAction.request.url else { return }
        url.log()
        
        switch url.scheme {
        case "kakaokompassauth", "kakaolink":
            url.open()
            decisionHandler(.cancel)
            break
        case "coupang":
            popViewController()
            url.open()
            decisionHandler(.cancel)
            break
        default:
            decisionHandler(.allow)
            break
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ai.stopAnimating()
        
        // Disable WKActionSheet on WKWebView
        webView.evaluateJavaScript("document.body.style.webkitTouchCallout='none';")
    }
}

// MARK: - WKWebView
extension WKWebView {
    func load(urlString: String) {
        guard let url: URL = urlString.encode.url else { return }
        load(url.request)
    }
    
    // MARK: - Cookies
    
    func cleanAllCookies() {
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
}
