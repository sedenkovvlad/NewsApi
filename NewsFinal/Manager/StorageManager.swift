//
//  StorageManager.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation


protocol StorageManager {
    func fetchNews() -> [News]
    func saveNews(_ news: [News])
}


//MARK: - CoreData Manager
class StorageManagerImpl: StorageManager {
    
    private let coreDataStack: CoreDataStackProtocol = CoreDataStack.shared

    init() {}

    func fetchNews() -> [News] {
        coreDataStack.fetchData()
    }

    func saveNews(_ news: [News]) {
        coreDataStack.saveData(news: news)
    }
}

