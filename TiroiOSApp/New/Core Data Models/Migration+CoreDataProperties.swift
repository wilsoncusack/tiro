//
//  Migration+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/8/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData


extension Migration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Migration> {
        return NSFetchRequest<Migration>(entityName: "Migration")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var runOn: Date

}

extension Migration {
    convenience init(
        id: UUID = UUID(),
        name: String,
        runOn: Date = Date()
    ) {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.name = name
        self.runOn = runOn
    }
}
