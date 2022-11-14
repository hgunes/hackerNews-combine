//
//  NewsListView.swift
//  HackerNews
//
//  Created by Harun Gunes on 12/11/2022.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject private var newsListVM = NewsListViewModel()
    
    var body: some View {
        NavigationView {
            List(self.newsListVM.news, id: \.id) { newsVM in
                NavigationLink( destination: NewsDetailView(newsID: newsVM.id)) {
                    Text("\(newsVM.title)")
                }
                
            }
            .navigationTitle("Hacker News")
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
