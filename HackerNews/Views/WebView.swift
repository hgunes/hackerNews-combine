//
//  WebView.swift
//  HackerNews
//
//  Created by Harun Gunes on 13/11/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> UIViewType {
        guard let url = URL(string: self.url) else {
            fatalError("Invalid URL!")
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        guard let url = URL(string: self.url) else {
            fatalError("Invalid URL!")
        }
        
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    typealias UIViewType = WKWebView
    
    
}
