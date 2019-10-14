//
//  Activity+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI

public class Activity: NSManagedObject {
    
}



extension Activity : Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var date_created: Date
    @NSManaged public var activity_date: Date
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var notes: String?
    @NSManaged public var image: Data?
    @NSManaged public var image_name: String?
    @NSManaged public var participants: NSSet?
    @NSManaged public var tags: NSSet?
    @NSManaged public var created_by: User
    
    static func create(activity_date: Date, title : String, notes : String?, image: Data?, created_by : User, image_name: String?, participants : NSSet?, tags : NSSet?, in context: NSManagedObjectContext) {
        let newActivity = Activity(context: context)
        newActivity.id = UUID()
        newActivity.date_created = Date()
        newActivity.activity_date = activity_date
        newActivity.title = title
        newActivity.notes = notes
        newActivity.image = image
        newActivity.created_by = created_by
        newActivity.image_name = image_name
        newActivity.participants = participants
        newActivity.tags = tags
    }

}

extension Activity {
    
    convenience init(
        id: UUID = UUID(),
        date_created : Date = Date(),
        activity_date: Date,
        title: String,
        image: Data?,
        notes: String?,
        created_by: User,
        participants : NSSet)
    {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.date_created = date_created
        self.activity_date = activity_date
        self.title = title
        self.image = image
        self.notes = notes
        self.created_by = created_by
        self.participants = participants
    }
    
}

// MARK: Generated accessors for participants
extension Activity {

    @objc(addParticipantsObject:)
    @NSManaged public func addToParticipants(_ value: Learner)

    @objc(removeParticipantsObject:)
    @NSManaged public func removeFromParticipants(_ value: Learner)

    @objc(addParticipants:)
    @NSManaged public func addToParticipants(_ values: NSSet)

    @objc(removeParticipants:)
    @NSManaged public func removeFromParticipants(_ values: NSSet)

}
