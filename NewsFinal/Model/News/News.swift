//
//  NewsModel.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation



class News: Codable {
    var title: String?
    var description: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: String?
    var isFavorite: Bool = false
    var ID = UUID().uuidString
    
    init?(title: String?, url: URL?, urlToImage: URL?, publishedAt: String?) {
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
    }
}


class Articles: Codable {
    var articles: [News]
    private enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }
}


