//
//  WebViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/06.
//

import UIKit
import WebKit

// The Ultimate Guide to WKWebView - https://www.hackingwithswift.com/articles/112/the-ultimate-guide-to-wkwebview
final class WebViewController: BaseTabViewController {
    // MARK: - Properties

    private let scriptMessageHandler = "scriptHandler"
    private var urlString: String?

    // MARK: - Views

    private lazy var configuration: WKWebViewConfiguration = {
        let contentController = WKUserContentController()
        contentController.add(self, name: scriptMessageHandler)

        let configuration = WKWebViewConfiguration()
        configuration.dataDetectorTypes = [.all]
        configuration.userContentController = contentController
        return configuration
    }()

    private lazy var webView: BaseWebView = {
        let webView = BaseWebView(configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
//        webView.customUserAgent = "My Awesome App"

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)

        webView.scrollView.delegate = self
        return webView
    }()

    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var progressView = BaseProgressView()
    private lazy var goBackFloatingButton = FloatingButton.goBack(view: view, webView: webView)
    private lazy var scrollToTopFloatingButton = FloatingButton.scrollToTop(view: view, scrollView: webView.scrollView)

    // MARK: - Life Cycle

    init(urlString: String, title: String = "") {
        self.urlString = urlString

        super.init(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        removeCache()
        loadWebView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        goBackFloatingButton.create()
        scrollToTopFloatingButton.create()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        goBackFloatingButton.remove()
        scrollToTopFloatingButton.remove()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case #keyPath(WKWebView.estimatedProgress):
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)

        case #keyPath(WKWebView.title):
            webView.title?.description.log()

        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    deinit {
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
    }

    // MARK: - Methods

    private func removeCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler: { })
    }

    private func setupViews() {
        view.addSubviews(
            progressView
        )

        contentView.addSubviews(
            webView,
            activityIndicatorView
        )

        NSLayoutConstraint.activate([
            progressView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),

            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            webView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

        addPopButton()
    }

    private func loadWebView() {
        guard
            let urlString = urlString,
            let encodedString = urlString.encode,
            let url = encodedString.toURL
        else {
//            alert(
//                title: "실행 오류",
//                message: "주소가 유효하지 않기 때문에\n해당 페이지를 열 수 없습니다."
//            ) { _ in
//                self.popViewController()
//            }
            toast("실행 오류\n\n주소가 유효하지 않기 때문에\n해당 페이지를 열 수 없습니다.")
            popViewController()
            return
        }

        if url.scheme == "zzimss" {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return
            }

            let items = components.queryItems ?? []
            print(items)

            switch url.host {
            case "terms":
                requestTerms(items: items)

            default:
                break
            }
        } else if url.canOpenURL {
            webView.load(url.toURLRequest)
        } else {
            toast("실행 오류\n\n주소가 유효하지 않기 때문에\n해당 페이지를 열 수 없습니다.")
            popViewController()
        }
    }

    private func requestTerms(items: [URLQueryItem]) {
//        let params = items.reduce(into: [:]) { params, queryItem in
//            params[queryItem.name] = queryItem.value
//        }
//
//        APIManager.shared.request(api: .terms, params: params) { [weak self] result in
//            guard let self = self, let result = result else { return }
//
//            switch result.code {
//            case .success:
//                guard let info = result.info else { return }
//
//                if let content = info["terms_content"] as? String {
//                    self.webView.loadHTMLString(content, baseURL: nil)
//                }
//            default:
//                self.toast(result.msg)
//            }
//        }
    }

    var returnMessage: StringHandler?

    private func passMessage(_ message: String) {
        returnMessage?(message)
        popViewController()
    }
}

// MARK: - WKUIDelegate

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        alert(message: message) { _ in
            completionHandler()
        }
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        alertTwoOptions(
            message: message,
            defaultHandler: { _ in
                completionHandler(true)
            },
            cancelHandler: { _ in
                completionHandler(false)
            }
        )
    }

    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        navigationAction.request.url?.absoluteString.log()

        guard navigationAction.targetFrame == nil else {
            return nil
        }

        webView.load(navigationAction.request)

        return nil
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        goBackFloatingButton.hide()
        scrollToTopFloatingButton.hide()

        activityIndicatorView.startAnimating()

        UIView.animate(withDuration: 0.25, animations: {
            self.progressView.alpha = 1.0
        })
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            navigationAction.description.log("cancel: ")
            decisionHandler(.cancel)
            return
        }

        url.absoluteString.log("allow: ")
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()

        UIView.animate(withDuration: 0.25, animations: { () in
            self.progressView.alpha = 0.0
        }) { _ in
            self.progressView.setProgress(0.0, animated: false)

            self.stoppedScrolling(scrollView: webView.scrollView)
        }

        // Disable WKActionSheet on WKWebView
        webView.evaluateJavaScript("document.body.style.webkitTouchCallout='none';")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        error.localizedDescription.log()
    }
}

// MARK: - WKScriptMessageHandler

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == scriptMessageHandler {
            passMessage(message.body as! String)
        }
    }
}

// MARK: - UIScrollViewDelegate

extension WebViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.contentOffset.y == 0
//            ? scrollToTopFloatingButton.hide()
//            : scrollToTopFloatingButton.show()
//    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startScrolling()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        startScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stoppedScrolling(scrollView: scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling(scrollView: scrollView)
    }

    private func startScrolling() {
        view.endEditing(true)
    }

    private func stoppedScrolling(scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            goBackFloatingButton.hide()
            scrollToTopFloatingButton.hide()
        } else {
            if webView.canGoBack {
                goBackFloatingButton.show()
                scrollToTopFloatingButton.hide()
            } else {
                goBackFloatingButton.hide()
                scrollToTopFloatingButton.show()
            }
        }
    }
}
