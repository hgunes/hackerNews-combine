//
//  NewsDetailViewModel.swift
//  HackerNews
//
//  Created by Harun Gunes on 12/11/2022.
//

import Foundation
import Combine

class NewsDetailViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    @Published private var news: News?
    
    func fetchNewsDetails(newsID: Int) {
        self.cancellable = NetworkManager().getNews(newsID: newsID)
            .catch { _ in Just(News.placeholder())}
            .sink(receiveCompletion: { _ in }, receiveValue: { news in
                self.news = news
            })
    }
}

extension NewsDetailViewModel {
    
    var title: String {
        return self.news?.title ?? "N/A"
    }
    
    var url: String {
        return self.news?.url ?? "N/A"
    }
}
