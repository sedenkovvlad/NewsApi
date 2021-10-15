//
//  FavoriteViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 22.09.2021.
//

import UIKit
import Firebase


class FavoriteViewController: UIViewController {
    
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: FavoriteCell.createLayout())
    private lazy var firebaseManager = FirebaseManager()
    private var viewModel: NewsFirebaseViewModelProtocol
  
   
    //MARK: - init
    init (viewModel: NewsFirebaseViewModel) {
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
}

//MARK: - CollectionView DataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell 
        let news = viewModel.news[indexPath.item]
        cell.configureCell(for: news, controller: self)
        cell.deleteButtonTapCallback = { [weak self] in
            self?.firebaseManager.deleteFavoriteFireBase(news: news)
            self?.viewModel.news.remove(at: indexPath.item)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        return cell
    }
}

//MARK: UI
extension FavoriteViewController {
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
    }
}


