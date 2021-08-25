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
    static let shared = DownloadManager()
    
    private init() {}
    
    func fetchNews(from url: String, competion: @escaping (Result<[News], DownloadError>) -> Void){
        
        guard let urlString = URL(string: url) else {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlString) { data, _ , error in
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

