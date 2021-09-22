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
    
    private let host = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=e8557278222c47fda6eea7a00e294681"
        
    init() {}
    
    func fetchNews(for category: Category, competion: @escaping (Result<[News], DownloadError>) -> Void){
        
        guard let url = URL(string: host + "&category=\(category.rawValue)") else {return}
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { data, _ , error in
            DispatchQueue.main.async {
                guard error == nil else {
                    competion(.failure(.errorNotNil))
                    return
                }
                
                guard let data = data else {
                    print("Data isEmpty")
                    competion(.failure(.noData))
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Articles.self, from: data)
                    let news = jsonData.articles
                    competion(.success(news))
                }catch let error as NSError{
                    print("Could not fetch: \(error), \(error.userInfo)")
                }
            }
        }
        dataTask.resume()
    }
}

