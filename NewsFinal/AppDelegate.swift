//
//  AppDelegate.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
      
        let authNavController = UINavigationController(rootViewController: AuthViewController())
        let mainController = MainViewController()
        
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if user == nil {
                self?.rootController(controller: authNavController)
            } else {
                self?.rootController(controller: mainController)
            }
        }
        
        return true
    }
    
    func rootController(controller: UIViewController){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

}

