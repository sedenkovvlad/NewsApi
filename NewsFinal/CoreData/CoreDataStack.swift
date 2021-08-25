//
//  CoreDataStack.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import UIKit
import CoreData

protocol CoreDataStackProtocol {
    func saveData(news: [News])
    func fetchData() -> [News]
}
class CoreDataStack: CoreDataStackProtocol{
    
    static let shared = CoreDataStack()
    private init() {}
    private let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
   
    
    //MARK: CoreDataStack
    private lazy var storeContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "NewsFinal")
      container.loadPersistentStores {
        (storeDescription, error) in
        if let error = error as NSError? {
          print("Unresolved error \(error), \(error.userInfo)")
        }
  }
      return container
    }()

    private lazy var context: NSManagedObjectContext = {
        storeContainer.viewContext
    }()
    
    
    //MARK: Save and Fetch function
    func saveData(news: [News]) {
        self.storeContainer.performBackgroundTask { [weak self] context in
            self?.converterData(news: news)
            self?.deleteData(context: context)
        }
    }
    
    func fetchData() -> [News] {
        var normalNewsArray = [News]()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(NewsEntity.publishedAt), ascending: false)]
        do {
            let fetchedNews = try context.fetch(fetchRequest)
            for newsEntity in fetchedNews {
                let normalNews = News(title: newsEntity.title , url: newsEntity.url, urlToImage: newsEntity.urlToImage, publishedAt: newsEntity.publishedAt)
                normalNewsArray.append(normalNews)
            }
        } catch let error as NSError{
            print("Could not fetch: - \(error), \(error.userInfo)")
        }
        return normalNewsArray
    }
    
    
    //MARK: - Private Function
    private func converterData(news: [News]){
        context.perform {
            for oneNews in news{
                let newsEntity = NewsEntity(context: self.context)
                newsEntity.title = oneNews.title
                newsEntity.url = oneNews.url
                newsEntity.urlToImage = oneNews.urlToImage
                newsEntity.publishedAt = oneNews.publishedAt
            }
            do{
            
                try self.context.save()
            }catch let error as NSError{
                print("Failure to save context: \(error), \(error.userInfo)")
            }
        }
    }
    
private func deleteData(context: NSManagedObjectContext){
    let fetchRequestResult = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
    let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequestResult)
    batchDelete.affectedStores = context.persistentStoreCoordinator?.persistentStores
    batchDelete.resultType = .resultTypeCount
    do{
        let object = try context.execute(batchDelete) as? NSBatchDeleteResult
        print("Delete object -\(String(describing: object?.result))")
        try context.save()
    }catch let error as NSError{
        print("Deleting Error: \(error), \(error.userInfo)")
    }
}
}
