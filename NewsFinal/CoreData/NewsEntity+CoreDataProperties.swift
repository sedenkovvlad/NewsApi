//
//  NewsEntity+CoreDataProperties.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: URL?
    @NSManaged public var publishedAt: String?
    @NSManaged public var urlToImage: URL?

}

extension NewsEntity : Identifiable {

}
