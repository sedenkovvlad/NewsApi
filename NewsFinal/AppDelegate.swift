//
//  AppDelegate.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dataProvider = DataProvider(
            storageManager: StorageManagerImpl(),
            downloadManager: DownloadManager(),
            reachabilityManager: ReachabilityManager()
        )
        let viewModel = NewsViewModelImpl(dataProvider: dataProvider, converterDate: ConverterDate())
        let newsController = NewsViewController(viewModel: viewModel)
        let webController = WebViewController()
        let navController = UINavigationController(rootViewController: newsController)
        navController.viewControllers = [webController, newsController]
        navController.navigationBar.tintColor = .orange
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        
        return true
    }

}

