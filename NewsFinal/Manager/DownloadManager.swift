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
    
    private let host = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=75325cb36fdb473abcb269dc04991c40"
        
    init() {}
    
    func fetchNews(for category: Category, completion: @escaping (Result<[News], DownloadError>) -> Void) {
        guard let url = URL(string: host + "&category=\(category.rawValue)") else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, _ , error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.errorNotNil))
                    return
                }
                guard let data = data else {
                    print("Data isEmpty")
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Articles.self, from: data)
                    let news = jsonData.articles
                    completion(.success(news))
                } catch let error as NSError {
                    print("Could not fetch: \(error), \(error.userInfo)")
                }
            }
        }
        dataTask.resume()
    }
    
}

