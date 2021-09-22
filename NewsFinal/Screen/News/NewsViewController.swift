//
//  NewsViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit
import FirebaseAuth

class NewsViewController: UIViewController {
    
    private var viewModel: NewsViewModelProtocol
    private var tableView = UITableView()
    

    
 
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = viewModel.categoryMenu(tableView: tableView)
        navigationItem.leftBarButtonItem = viewModel.configureExitButton()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getNewsData(category: Category.general) { [weak self ]result in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure:
                print(#function, "failure")
            }
            print("Мы загрузили заново новости")
        }
    }
    
    //MARK: - Configure TableView
    func configureTableView(){
        view.addSubview(tableView)
//        tableView.rowHeight = 200
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.pin(to: view)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: - TableViewDataSource
extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as!  NewsCell
         
        let news = viewModel.news[indexPath.row]
        
        
        //title
        cell.titleLabel.text = news.title
        //date
        cell.dateLabel.text = viewModel.getDate(for: indexPath.row)
        
          //image
        if news.urlToImage != nil{
            viewModel.getImage(url: news.urlToImage) { image in
                cell.imageNews.image = image
            }
        }else{
            cell.imageNews.image = UIImage(named: "noImage")
        }
        
        //button
        cell.favoriteButton.isSelected = news.isFavorite
        cell.bringSubviewToFront(cell.favoriteButton)
        cell.buttonTapCallback = { [weak self] in
            news.isFavorite.toggle()
            if cell.favoriteButton.isSelected == false{
                self?.viewModel.addFavorite(news: news, indexPath: indexPath, image: cell.imageNews)
                cell.favoriteButton.isSelected = true
            }else{
                self?.viewModel.deleteFavorite(news: news)
                cell.favoriteButton.isSelected = false
            }
        }
    
        return cell
    }
}
//MARK: TableViewDelegate
extension NewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WebViewController()
        let news = viewModel.news[indexPath.row]
        vc.URL = news.url
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





