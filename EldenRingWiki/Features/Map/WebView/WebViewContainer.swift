//
//  WebViewContainer.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var webViewModel: WebViewModel

    func makeCoordinator() -> WebViewContainer.Coordinator {
        let coordinator = Coordinator(self, webViewModel)
        webViewModel.webView.navigationDelegate = coordinator
        return coordinator
    }

    func makeUIView(context _: Context) -> WKWebView {
        webViewModel.webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject private var webViewModel: WebViewModel
        private let parent: WebViewContainer

        init(_ parent: WebViewContainer, _ webViewModel: WebViewModel) {
            self.parent = parent
            self.webViewModel = webViewModel
        }

        func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
            webViewModel.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
            webViewModel.isLoading = false

            webView.evaluateJavaScript("document.getElementsByClassName('left-arrow')[0].click()")
            webView.evaluateJavaScript("document.getElementsByClassName('right-arrow')[0].click()")

            webView.evaluateJavaScript("document.getElementsByClassName('result')[0].click()")
        }

        func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
            webViewModel.isLoading = false
        }
    }
}
