//
//  NewsFirebase.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.09.2021.
//

import Foundation


class NewsFirebase{
    var title: String
    var url: String
    var newsURL: String
    var uuidString: String
   
    init(title: String, url: String,newsURL: String, uuidString: String) {
        self.title = title
        self.url = url
        self.newsURL = newsURL
        self.uuidString = uuidString
    }
}
