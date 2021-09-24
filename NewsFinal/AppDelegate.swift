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
        
        
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if user == nil {
                let authNavController = UINavigationController(rootViewController: AuthViewController())
                self?.rootController(controller: authNavController)
            } else {
                let mainController = MainViewController()
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

