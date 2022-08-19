//
//  WebViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func searchByName(_ searchItem: String) {
        var urlComponents = URLComponents(string: Constants.API.mapUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "search", value: searchItem)]
        
        guard let url = urlComponents?.url else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
