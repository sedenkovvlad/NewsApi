//
//  NewsFirebaseViewModel.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 25.09.2021.
//

import Foundation
import UIKit
import Firebase

protocol NewsFirebaseViewModelProtocol{
    var news: [NewsFirebase] {get set}
    func getNewsFirebase(collectionView: UICollectionView)
}


final class NewsFirebaseViewModel: NewsFirebaseViewModelProtocol {
    
    lazy var news: [NewsFirebase] = []
    
    func getNewsFirebase(collectionView: UICollectionView) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore().collection("users").document(userID).collection("news")
        db.addSnapshotListener { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            self?.news = documents.map { snapshot -> NewsFirebase in
                let data = snapshot.data()
                let title = data["title"] as? String ?? "Title is missing"
                let webUrl = data["webUrl"] as? String ?? "URL is missing"
                let newsURL = data["newsURL"] as? String ?? "News URL is missing"
                let uuidString = data["uuidString"] as? String ?? "uuidString is missing"
                return NewsFirebase(title: title, url: webUrl, newsURL: newsURL, uuidString: uuidString)
            }
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
}
