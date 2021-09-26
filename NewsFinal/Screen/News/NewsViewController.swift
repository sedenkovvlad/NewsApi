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
     var tableView = UITableView()
    
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
   

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("NewsViewController deinit")
    }
    
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNewsData(category: Category.general) { [weak self ]result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure:
                print(#function, "failure")
            }
            print("мы снова заработали")
        }
        
        navigationItem.rightBarButtonItem = viewModel.categoryMenu(tableView: tableView)
        navigationItem.leftBarButtonItem = configureExitButton()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Configure TableView
    func configureTableView(){
        view.addSubview(tableView)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
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
        cell.configure(news: news, viewModel: viewModel)
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

//MARK: - Button signOut
extension NewsViewController{
    @objc func signOut(){
        do{
            try Auth.auth().signOut()
            let vc = AuthViewController()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            appDelegate.window?.rootViewController = vc
            present(vc, animated: true, completion: nil)
        }catch let error as NSError{
            print("Error signing out: \(error)")
        }
        
    }
    
    func configureExitButton() -> UIBarButtonItem{
        let button = UIButton()
        button.setTitle("\u{2347}", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(25)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        let barItem = UIBarButtonItem(customView: button)
        return barItem
        
    }
}





