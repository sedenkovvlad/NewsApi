//
//  DownloadManager.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation


//MARK: - Error
enum DownloadError: Error {
    case noData
    case errorNotNil
}

//MARK: - Dowload News Manager
class DownloadManager {
    
    let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchNews(for category: Category, completion: @escaping (Result<Articles?, Error>) -> Void) {
        guard var url = URL(string: "https://newsapi.org/v2/top-headlines") else { return }
        let URLParams = [
            "country": "ru",
            "category": category.rawValue,
            "apiKey": "75325cb36fdb473abcb269dc04991c40",
        ]
        url = url.appendingQueryParameters(URLParams)
        dataFetcher.fetchJSONData(url: url, response: completion)
    }
}
