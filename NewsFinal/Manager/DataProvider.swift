//
//  DataProvider.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation
import UIKit

final class DataProvider {

    private let storageManager: StorageManager
    private let downloadManager: DownloadManager
    private let reachabilityManager: ReachabilityManager
    
    init(
        storageManager: StorageManager,
        downloadManager: DownloadManager,
        reachabilityManager: ReachabilityManager
    ) {
        self.storageManager = storageManager
        self.downloadManager = downloadManager
        self.reachabilityManager = reachabilityManager
    }
    
    func getNewsData(category: Category, completion: @escaping (Result<[News], Error>) -> Void) {
        guard reachabilityManager.isConnectedToNetwork() else {
            let cachedNews = storageManager.fetchNews()
            completion(.success(cachedNews))
            return
        }

        downloadManager.fetchNews(for: category) { [weak self] result in
            switch result {
            case .success(let fetchedNews):
                completion(.success(fetchedNews))
                self?.storageManager.saveNews(fetchedNews)

            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
   
}

