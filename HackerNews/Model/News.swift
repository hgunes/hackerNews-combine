//
//  News.swift
//  HackerNews
//
//  Created by Harun Gunes on 12/11/2022.
//

import Foundation

struct News: Decodable {
    
    let id: Int
    let title: String
    let url: String
}

extension News {
    
    static func placeholder() -> News {
        return News(id: 0, title: "N/A", url: "")
    }
}
