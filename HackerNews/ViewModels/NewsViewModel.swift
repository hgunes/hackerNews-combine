//
//  NewsViewModel.swift
//  HackerNews
//
//  Created by Harun Gunes on 12/11/2022.
//

import Foundation
import Combine

class NewsListViewModel: ObservableObject {
    
    @Published var news = [NewsViewModel]()
    private var cancellable: AnyCancellable?
    
    init() {
        fetchNews()
    }
    
    func fetchNews() {
        self.cancellable = NetworkManager().getTopNews().map { news in
            news.map { NewsViewModel(news: $0) }
        }.sink(receiveCompletion: { _ in }, receiveValue: { newsVM in
            self.news = newsVM
        })
    }
}

struct NewsViewModel {
    
    let news: News

    var id: Int {
        return self.news.id
    }

    var title: String {
        return self.news.title
    }

    var url: String {
        return self.news.url
    }
}
