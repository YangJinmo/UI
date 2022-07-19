//
//  WebViewController.swift
//  UI
//
//  Created by Jmy on 2021/11/06.
//

import UIKit
import WebKit

final class WebViewController: BaseTabViewController {
    // MARK: - Properties

    private let scriptMessageHandler = "scriptHandler"
    private var urlString: String?

    // MARK: - Initialization

    init(urlString: String, title: String = "") {
        self.urlString = urlString

        super.init(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private var webView: BaseWebView!
    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var progressView = BaseProgressView()
    private lazy var floatingButton = FloatingButton(view: view, scrollView: webView.scrollView)

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setWebView()
        setupViews()
        removeCache()
        loadWebView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        floatingButton.create()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        floatingButton.remove()
    }

    // MARK: - Methods

    private func removeCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler: { })
    }

    private func setWebView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: scriptMessageHandler)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = BaseWebView(configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        webView.scrollView.delegate = self
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    private func setupViews() {
        view.addSubviews(
            progressView
        )

        contentView.addSubviews(
            webView,
            activityIndicatorView
        )

        Constraint.activate([
            progressView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            progressView.bottomAnchor.constraint(equalTo: contentView.topAnchor),

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

    var returnMessage: ReturnString?

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
        alertOption(
            message: message,
            confirmHandler: { _ in
                completionHandler(true)
            },
            cancelHandler: { _ in
                completionHandler(false)
            }
        )
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorView.startAnimating()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            return
        }

        url.absoluteString.log()

        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
        progressView.isHidden = true

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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height - scrollView.frame.height

        if scrollView.contentOffset.y >= contentHeight {
//            if isLoaded && (hasMoreReviews || hasMoreRecommendReviews) {
//                loadMore()
//            }
        }
    }

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
        floatingButton.hide()
    }

    private func stoppedScrolling(scrollView: UIScrollView) {
        scrollView.contentOffset.y == 0
            ? floatingButton.hide()
            : floatingButton.show()
    }
}
