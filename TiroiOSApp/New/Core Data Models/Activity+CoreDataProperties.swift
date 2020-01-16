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
    @NSManaged public var link: String?
    @NSManaged public var image: Data?
    @NSManaged public var image_name: String?
    @NSManaged public var participants: NSSet?
    @NSManaged public var tags: NSSet?
    @NSManaged public var created_by: User
    

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
