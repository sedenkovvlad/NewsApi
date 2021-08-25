//
//  StorageManager.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation


protocol StorageManagerProtocol {
    func fetchNews() -> [News]
    func saveNews(_ news: [News])
}


//MARK: - CoreData Manager
class StorageManager: StorageManagerProtocol {
    private let coreDataStack: CoreDataStackProtocol = CoreDataStack.shared

    static let shared = StorageManager()

    private init() {}

    func fetchNews() -> [News] {
        coreDataStack.fetchData()
    }

    func saveNews(_ news: [News]) {
        coreDataStack.saveData(news: news)
    }
}

