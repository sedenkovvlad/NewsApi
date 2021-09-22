//
//  MainViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 22.09.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapBar()
    }
    
    
    func setupTapBar(){
        let newsVC = createNavController(vc: NewsViewController(viewModel: createViewModel()), image: UIImage(systemName: "newspaper"))
        newsVC.navigationBar.tintColor = .orange
        newsVC.tabBarItem.title = "News"
        let favoriteVC = createNavController(vc: FavoriteViewController(), image: UIImage(systemName: "star"))
        favoriteVC.tabBarItem.title = "Favorite"
        viewControllers = [newsVC, favoriteVC]
    }
}


extension MainViewController{
    func createNavController(vc: UIViewController, image: UIImage?) -> UINavigationController{
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image = image
        return navController
    }
}

extension MainViewController{
    func createViewModel() -> NewsViewModelImpl{
        let dataProvider = DataProvider(
            storageManager: StorageManagerImpl(),
            downloadManager: DownloadManager(),
            reachabilityManager: ReachabilityManager()
        )
        let viewModel = NewsViewModelImpl(dataProvider: dataProvider, converterDate: ConverterDate(), firebaseManager: FirebaseManager())
        return viewModel
    }
}


