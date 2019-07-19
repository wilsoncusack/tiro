//
//  Learner+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI

public class Learner: NSManagedObject {
    
}

extension Learner : Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Learner> {
        return NSFetchRequest<Learner>(entityName: "Learner")
    }

    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var profile_image_name: String?
    @NSManaged public var questions: NSSet?
    @NSManaged public var activities: NSSet?
    @NSManaged public var created_by: User

}

extension Learner {
    static func create(name: String, created_by: User, profile_image_name : String?, in context: NSManagedObjectContext) {
        let learner = Learner(context: context)
        learner.id = UUID()
        learner.name = name
        learner.created_by = created_by
        learner.profile_image_name = profile_image_name
    }
}

extension Learner {
    convenience init(
        id: UUID = UUID(),
        name : String,
        created_by : User,
        profile_image_name: String)
    {
        self.init(context: AppDelegate.viewContext)
        self.name = name
        self.created_by = created_by
        self.profile_image_name = profile_image_name
        
    }
}

// MARK: Generated accessors for questions
extension Learner {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}

// MARK: Generated accessors for activities
extension Learner {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}
