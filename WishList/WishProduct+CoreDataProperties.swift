//
//  WishProduct+CoreDataProperties.swift
//  WishList
//
//  Created by CaliaPark on 4/18/24.
//
//

import Foundation
import CoreData


extension WishProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishProduct> {
        return NSFetchRequest<WishProduct>(entityName: "WishProduct")
    }

    @NSManaged public var detail: String?
    @NSManaged public var id: Int16
    @NSManaged public var thumnail: String?
    @NSManaged public var title: String?

}

extension WishProduct : Identifiable {

}
