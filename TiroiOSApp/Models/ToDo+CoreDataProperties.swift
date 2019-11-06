//
//  ToDo+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/17/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo : Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var date_created: Date
    @NSManaged public var due_date: Date?
    @NSManaged public var notes: String?
    @NSManaged public var link: String?
    @NSManaged public var done: Bool
    @NSManaged public var createdBy: User
    @NSManaged public var learner: Learner?
    @NSManaged public var notification_id: String?
    @NSManaged public var tags: NSSet?
    @NSManaged public var saved_to_activity: Bool

}

extension ToDo{
    convenience init(
        id : UUID = UUID(),
        title: String,
        date_created: Date = Date(),
        due_date: Date?,
        notes: String?,
        link: String?,
        done: Bool = false,
        createdBy: User,
        learner: Learner?,
        notification_id: String?,
        tags: NSSet?,
        saved_to_activity : Bool = false
        
    ){
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.title = title
        self.date_created = date_created
        self.due_date = due_date
        self.notes = notes
        self.link = link
        self.done = done
        self.createdBy = createdBy
        self.learner = learner
        self.notification_id = notification_id
        self.tags = tags
    }
}

// MARK: Generated accessors for reminders
extension ToDo {

    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)

    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)

    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)

    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)

}
