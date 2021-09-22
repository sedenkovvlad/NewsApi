//
//  FirebaseManager.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 20.09.2021.
//

import Foundation
import UIKit
import Firebase

class FirebaseManager{
   
   
    init() {}
  
    func addFavorite(news: News,indexPath: IndexPath, image: UIImageView?){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection("users").document(userID).collection("news").document(news.ID)
        upload(news: news, indexPath: indexPath , currentUserID: userID, photo: image) { result in
            switch result{
            case .success(let url):
                db.setData([
                    "title": news.title ?? "Not title",
                    "description": news.description ?? "Not description",
                    "newsURL": url.absoluteString,
                    "uuidString": news.ID
                ])
            case .failure(let error as NSError):
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteFavorite(news: News){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore().collection("users").document(userID).collection("news").document(news.ID)
        let storage = Storage.storage().reference().child("newsImage").child(news.ID)
        db.delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            }else{
                print("Document successfully removed!")
            }
            storage.delete { error in
                if let error = error{
                    print("Error removing image: \(error)")
                }else{
                    print("Image successfully removed!")
                }
            }
        }
    }
    private func upload(news: News,indexPath: IndexPath,currentUserID: String, photo: UIImageView?, completion: @escaping (Result<URL, Error>) -> Void){
        
        let ref = Storage.storage().reference().child("newsImage").child(news.ID)
        guard let imageData = photo?.image?.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        ref.putData(imageData, metadata: metadata) { _ , error in
            
            if let error = error{
                completion(.failure(error))
            }
            ref.downloadURL { url , error in
                
                if let error = error{
                    completion(.failure(error))
                }
                guard let url = url else { return }
                completion(.success(url))
            }
        }
    }
}
