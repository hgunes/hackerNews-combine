//
//  NewsDetailView.swift
//  HackerNews
//
//  Created by Harun Gunes on 12/11/2022.
//

import SwiftUI

struct NewsDetailView: View {
    
    @ObservedObject private var newsDetailVM: NewsDetailViewModel
    var newsID: Int
    
    init(newsID: Int) {
        self.newsID = newsID
        self.newsDetailVM = NewsDetailViewModel() 
    }
    
    var body: some View {
        VStack {
            Text(self.newsDetailVM.title)
            WebView(url: self.newsDetailVM.url)
        }
        .onAppear {
            self.newsDetailVM.fetchNewsDetails(newsID: newsID)
        }
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(newsID: 100)
    }
}
