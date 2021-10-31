//
//  NewsViewModel.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation
import FirebaseAuth
import UIKit

protocol NewsViewModelProtocol {
    var news: [News] { get set }
    var imageCache: NSCache<NSString, UIImage> { get set }
    func getNewsData(category: Category, completion: @escaping (Result<Void, Error>) -> Void)
    func getDate(date: String?) -> String
    func getImage(url: URL?, completion: @escaping (UIImage?) -> Void)
    func addFavorite(news: News, image: UIImageView?)
    func deleteFavorite(news: News)
}

final class NewsViewModel: NewsViewModelProtocol {
   
    private let dataProvider: DataProvider
    private let converterDate: ConverterDate
    private let firebaseManager: FirebaseManager
    lazy var news: [News] = []
    lazy var imageCache = NSCache<NSString, UIImage>()
   
    
    //MARK: init
    init(dataProvider: DataProvider, converterDate: ConverterDate, firebaseManager: FirebaseManager) {
        self.dataProvider = dataProvider
        self.converterDate = converterDate
        self.firebaseManager = firebaseManager
    }
    
    
    //MARK: - Converter Date
    func getDate(date: String?) -> String {
        guard let date = date else { return "" }
        guard let dateString = converterDate.formatDate(from: date) else { return "" }
        let newsDate = converterDate.formatDateString(from: dateString)
        return newsDate
    }
}


//MARK: Networking
extension NewsViewModel {
    // Get News
    func getNewsData(category: Category, completion: @escaping (Result<Void, Error>) -> Void) {
        dataProvider.getNewsData(category: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let loadedNews):
                self.news = loadedNews
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    // Download Image from URL and Cache
    func getImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = url else { return }
        if let cachedImage = imageCache.object(forKey: urlString.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        let request = URLRequest(url: urlString, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
         
            guard
                error == nil,
                let data = data,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                if urlString == url { 
            self?.imageCache.setObject(image, forKey: urlString.absoluteString as NSString)
                completion(image)
                }
            }
        }.resume()
    }
}


//MARK: - FireBase
extension NewsViewModel {
    func addFavorite(news: News, image: UIImageView?) {
        firebaseManager.addFavorite(news: news,image: image)
    }
    func deleteFavorite(news: News) {
        firebaseManager.deleteFavorite(news: news)
    }
}
