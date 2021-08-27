//
//  NewsViewModel.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation
import UIKit

protocol NewsViewModel {
    var itemSelection: (() -> Void)? { get set }
    var news: [News] { get }
    func getNewsData(category: Category, completion: @escaping (Result<Void, Error>) -> Void)
    func getDate(for itemIndex: Int) -> String
    func categoryMenu(tableView: UITableView) -> UIBarButtonItem
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void)
}


final class NewsViewModelImpl: NewsViewModel {
    
    private let dataProvider: DataProvider
    private let converterDate: ConverterDate
    private let imageCache = NSCache<NSString, UIImage>()
    
    var itemSelection: (() -> Void)?
    
    private(set) var news: [News] = []
    
    init(dataProvider: DataProvider, converterDate: ConverterDate) {
        self.dataProvider = dataProvider
        self.converterDate = converterDate
    }
    
    //MARK: - Get News
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
    
    //MARK: - Converter Date
    func getDate(for itemIndex: Int) -> String{
        guard let publishedAt = news[itemIndex].publishedAt else {return ""}
        let dateString = converterDate.formatDate(from: publishedAt)
        let date = converterDate.formatDateString(from: dateString!)
        return date
    }
    
    //MARK: - Cetegory Menu
    func categoryMenu(tableView: UITableView) -> UIBarButtonItem{
        var categoryAction: UIMenu{
            let menuAction = Category.allCases.map { item -> UIAction in
                let name = item.rawValue
                return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemImage)) { [weak self](_) in
                    self?.getNewsData(category: item) { result in
                        switch result {
                        case .success:
                            tableView.reloadData()
                        case .failure:
                            print(#function, "failure")
                        }
                    }
                    self?.itemSelection?()
                }
            }
            return UIMenu(title: "Change Category", children: menuAction)
        }
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "scroll"), menu: categoryAction)
        return categoryButton
    }
    
    //MARK: - Download Image from URL and Cache
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void){
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString){
            completion(cachedImage)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard
                error == nil,
                let data = data,
                let image = UIImage(data: data)
            else { return }
    
            self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
