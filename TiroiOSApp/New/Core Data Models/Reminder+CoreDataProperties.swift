//
//  Reminder+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/17/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var id: UUID
    @NSManaged public var notification_id: String
    @NSManaged public var title: String
    @NSManaged public var body: String?
    @NSManaged public var date: Date
    @NSManaged public var toDo: ToDo?

}

extension Reminder{
    convenience init(
        id : UUID = UUID(),
        notifcation_id : String,
        title: String,
        body: String?,
        date: Date,
        toDo: ToDo?
    ){
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.notification_id = notification_id
        self.title = title
        self.body = body
        self.date = date
        self.toDo = toDo
    }
}
