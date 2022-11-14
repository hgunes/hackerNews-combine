//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Harun Gunes on 12/11/2022.
//

import Foundation
import Combine

class NetworkManager {
    
    func getNews(newsID: Int) -> AnyPublisher<News, Error> {
        let url = "https://hacker-news.firebaseio.com/v0/item/\(newsID).json?print=pretty"
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getTopNews() -> AnyPublisher<[News], Error> {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap { newsIDs in
                return self.mergeNews(ids: newsIDs)
            }
            .scan([]) { newsArray, news -> [News] in
                return newsArray + [news]
            }
            .eraseToAnyPublisher()
    }
    
    private func mergeNews(ids newsIDs: [Int]) -> AnyPublisher<News, Error> {
        
        let newsIDs = Array(newsIDs.prefix(50))
        let initialPublisher = getNews(newsID: newsIDs[0])
        let remainder = Array(newsIDs.dropFirst())
        
        return remainder.reduce(initialPublisher) { combined, id in
            return combined.merge(with: getNews(newsID: id))
                .eraseToAnyPublisher()
        }
    }
    
}
