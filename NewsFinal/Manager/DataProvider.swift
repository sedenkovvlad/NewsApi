//
//  DataProvider.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation
import UIKit

class DataProvider {
    static let shared = DataProvider()

    private init(storageManager: StorageManagerProtocol = StorageManager.shared) {}

    
    private let storageManager = StorageManager.shared
    private let downloadManager = DownloadManager.shared
    private let reachabilityManager = ReachabilityManager.shared

    
    func getNewsData(urlString: String, completion: @escaping (Result<[News], Error>) -> Void) {
        guard reachabilityManager.isConnectedToNetwork() else {
            let cachedNews = storageManager.fetchNews()
            completion(.success(cachedNews))
            return
        }

        downloadManager.fetchNews(from: urlString) { result in
            switch result {
            case .success(let fetchedNews):
                completion(.success(fetchedNews))
                self.storageManager.saveNews(fetchedNews)

            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
   
}

