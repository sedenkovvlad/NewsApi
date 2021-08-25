//
//  NewsViewModel.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation
import UIKit

protocol NewsViewModelProtocol {
    var news: [News] { get }
    func getNewsData(urlString: String, completion: @escaping (Result<Void, Error>) -> Void)
    func getDate(for itemIndex: Int) -> String
    func categoryMenu(tableView: UITableView) -> UIBarButtonItem
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void)
}


class NewsViewModel: NewsViewModelProtocol{
    private let dataProvider = DataProvider.shared
    private let converterDate = ConverterDate.shared
    
    private(set) var news: [News] = []
    
    
    
    //MARK: - Get News
    func getNewsData(urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        dataProvider.getNewsData(urlString: urlString) { [weak self] result in
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
            let menuAction = Category.allCases.map { (item) -> UIAction in
                let name = item.rawValue
                return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemImage)) { [weak self](_) in
                    self?.getNewsData(urlString: item.api) { result in
                        switch result {
                        case .success:
                            tableView.reloadData()
                        case .failure:
                            print(#function, "failure")
                        }
                    }
                }
            }
            return UIMenu(title: "Change Category", children: menuAction)
        }
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "scroll"), menu: categoryAction)
        return categoryButton
    }
    
    //MARK: - Download Image from URL and Cache
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void){
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard
                error == nil,
                data != nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let self = self else {return}
    
            guard let image = UIImage(data: data!) else {return}
            DispatchQueue.main.async {
                completion(image)
            }
        }
        dataTask.resume()
    }
}
