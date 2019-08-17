//
//  BookEntity+CoreDataProperties.swift
//  Alexandria
//
//  Created by IcyBlast on 20/4/18.
//  Copyright © 2018 IcyBlast. All rights reserved.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var bookTitle: String?
    @NSManaged public var bookISBN: String?
    @NSManaged public var bookAuthor: String?
    @NSManaged public var bookPublisher: String?
    @NSManaged public var bookEdition: String?
    @NSManaged public var bookYearOfPublication: String?
    @NSManaged public var bookGenre: String?
    @NSManaged public var bookDescription: String?

}
