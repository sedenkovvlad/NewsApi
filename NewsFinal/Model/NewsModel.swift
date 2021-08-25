//
//  NewsModel.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation

struct News: Codable {
    var title: String?
    var url: URL?
    var urlToImage: URL?
    var publishedAt: String?
}

struct Articles: Codable {
    var articles: [News]
}
