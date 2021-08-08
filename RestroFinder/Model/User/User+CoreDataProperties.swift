//
//  UUser+CoreDataProperties.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-07-01.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String
    @NSManaged public var name: String
    @NSManaged public var password: String
}
