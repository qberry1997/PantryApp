//
//  PantryItem+CoreDataProperties.swift
//  FInalApp
//
//  Created by Quinn Berry on 11/24/20.
//  Copyright © 2020 Quinn Berry. All rights reserved.
//
//

import Foundation
import CoreData


extension PantryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PantryItem> {
        return NSFetchRequest<PantryItem>(entityName: "PantryItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var desc: String?
    @NSManaged public var current: Double
    @NSManaged public var threshold: Double

}
