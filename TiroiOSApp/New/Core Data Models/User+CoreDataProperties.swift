//
//  User+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData

public class User: NSManagedObject {
    
}

extension User: Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var birthday: Date?
    @NSManaged public var date_created: Date
    @NSManaged public var is_managed: Bool
    @NSManaged public var first_name: String
    @NSManaged public var last_name: String
    @NSManaged public var image: Data?
    @NSManaged public var has_finished_setup: Bool
    @NSManaged public var questions: NSSet?
    @NSManaged public var learners: NSSet?
    @NSManaged public var activities: NSSet?
    @NSManaged public var managed_by: User
    @NSManaged public var managed_users: NSSet?
    
}

extension User {
    static func create(first_name: String, last_name : String, in context: NSManagedObjectContext) {
        let user = User(context: context)
        user.id = UUID()
        user.first_name = first_name
        user.last_name = last_name
        user.has_finished_setup = false
    }
}

extension User {
    convenience init(
        id: UUID = UUID(),
        birthday: Date?,
        date_created: Date = Date(),
        image: Data?,
        first_name : String,
        last_name : String,
        has_finished_setup : Bool = false)
    {
        self.init(context: AppDelegate.viewContext)
        self.id = id
        self.birthday = birthday
        self.date_created = date_created
        self.image = image
        self.first_name = first_name
        self.last_name = last_name
        
    }
    
    convenience init(
           id: UUID = UUID(),
           birthday: Date?,
           date_created: Date = Date(),
           created_by: User,
           image: Data?,
           first_name : String,
           last_name : String,
           has_finished_setup : Bool = false)
       {
           self.init(context: AppDelegate.viewContext)
           self.id = id
           self.birthday = birthday
           self.date_created = date_created
        self.image = image
           self.first_name = first_name
           self.last_name = last_name
        self.is_managed = true
        self.managed_by = created_by
           
       }
    
}


// MARK: Generated accessors for questions
extension User {
    
    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)
    
    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)
    
    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)
    
    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)
    
}

// MARK: Generated accessors for learners
extension User {
    
    @objc(addLearnersObject:)
    @NSManaged public func addToLearners(_ value: Learner)
    
    @objc(removeLearnersObject:)
    @NSManaged public func removeFromLearners(_ value: Learner)
    
    @objc(addLearners:)
    @NSManaged public func addToLearners(_ values: NSSet)
    
    @objc(removeLearners:)
    @NSManaged public func removeFromLearners(_ values: NSSet)
    
}

// MARK: Generated accessors for activities
extension User {
    
    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)
    
    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)
    
    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)
    
    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)
    
}
