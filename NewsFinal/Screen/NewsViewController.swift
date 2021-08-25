//
//  NewsViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    var viewModel: NewsViewModelProtocol!
    
    
    private var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = viewModel.categoryMenu(tableView: tableView)
        configureTableView()
        
        viewModel.getNewsData(urlString: Category.general.api) { [weak self ]result in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure:
                print(#function, "failure")
            }
        }
    }
    
    //MARK: - Configure
    func configureTableView(){
        view.addSubview(tableView)
        tableView.rowHeight = 200
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.pin(to: view)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell
        
        let news = viewModel.news[indexPath.row]
        cell?.titleLabel.text = news.title
        cell?.dateLabel.text = viewModel.getDate(for: indexPath.row)
        
        viewModel.getImage(url: news.urlToImage!) { image in
            cell?.imageNews.image = image
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WebViewController()
        let news = viewModel.news[indexPath.row]
        vc.URL = news.url
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
