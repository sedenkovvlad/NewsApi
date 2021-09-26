//
//  MainViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 22.09.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapBar()
    }
    
    
    private func setupTapBar(){
        let newsVC = createNavController(vc: NewsViewController(viewModel: createNewsViewModel()), image: UIImage(systemName: "newspaper"))
        newsVC.tabBarItem.title = "News"
        newsVC.navigationBar.tintColor = .orange
        let favoriteVC = createNavController(vc: FavoriteViewController(viewModel: createFavoriteViewModel()), image: UIImage(systemName: "star"))
        favoriteVC.tabBarItem.title = "Favorite"
        viewControllers = [newsVC, favoriteVC]
    }
}


extension MainViewController{
    private func createNavController(vc: UIViewController, image: UIImage?) -> UINavigationController{
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.image = image
        return navController
    }
}
//MARK: - Create ViewModels
extension MainViewController{
    private func createNewsViewModel() -> NewsViewModel{
        let dataProvider = DataProvider(
            storageManager: StorageManagerImpl(),
            downloadManager: DownloadManager(),
            reachabilityManager: ReachabilityManager()
        )
        let viewModel = NewsViewModel(dataProvider: dataProvider, converterDate: ConverterDate(), firebaseManager: FirebaseManager())
        return viewModel
    }
    
    private func createFavoriteViewModel() -> NewsFirebaseViewModel{
    let viewModel = NewsFirebaseViewModel()
        return viewModel
    }
}


