//
//  FavoriteViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 22.09.2021.
//

import UIKit
import Firebase

protocol FavoriteViewControllerOutput: AnyObject {
    func rowDeleted(with id: String)
}

class FavoriteViewController: UIViewController {
    
    var output: FavoriteViewControllerOutput?
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: FavoriteCell.createLayout())
    private lazy var firebaseManager = FirebaseManager()
    private let  viewModel: NewsFirebaseViewModelProtocol
    
    
    //MARK: - init
    init (viewModel: NewsFirebaseViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.getNewsFirebase(collectionView: collectionView)
    }
    
    //MARK: - Configure
    func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
    }
}

//MARK: - CollectionView DataSource
extension FavoriteViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell 
        let news = viewModel.news[indexPath.item]
    
        cell.configureCell(newsFirebase: news)
        cell.sharedButtonTapCallback = { [weak self] in
            let ac = UIActivityViewController(activityItems: [news.url], applicationActivities: nil)
            ac.isModalInPresentation = true
            self?.present(ac, animated: true)
        }
        cell.deleteButtonTapCallback = { [weak self] in
            self?.firebaseManager.deleteFavoriteFireBase(news: news)
            self?.output?.rowDeleted(with: news.uuidString)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        return cell
    }
}


