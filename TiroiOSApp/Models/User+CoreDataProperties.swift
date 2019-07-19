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

extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var first_name: String
    @NSManaged public var last_name: String
    @NSManaged public var has_finished_setup: Bool
    @NSManaged public var questions: NSSet?
    @NSManaged public var learners: NSSet?
    @NSManaged public var activities: NSSet?
    
}

extension User {
    static func create(first_name: String, last_name : String, in context: NSManagedObjectContext) {
        let user = User(context: context)
        user.id = UUID()
        user.first_name = first_name
        user.last_name = last_name
        user.has_finished_setup = false
        // return user
    }
}

extension User {
    convenience init(
        id: UUID = UUID(),
        first_name : String,
        last_name : String,
        has_finished_setup : Bool = false)
    {
        self.init(context: AppDelegate.viewContext)
        self.first_name = first_name
        self.last_name = last_name
        
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
