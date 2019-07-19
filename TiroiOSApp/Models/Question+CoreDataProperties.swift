//
//  Question+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData

public class Question: NSManagedObject {
    
}

extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var id: UUID
    @NSManaged public var question_text: String
    @NSManaged public var answer_text: String?
    @NSManaged public var date_created: Date
    @NSManaged public var asker: Learner
    @NSManaged public var created_by: User
    
    static func create(question_text: String, asker : Learner, answer_text : String?, created_by : User, in context: NSManagedObjectContext) {
        let newQuestion = Question(context: context)
        newQuestion.date_created = Date()
        newQuestion.id = UUID()
        newQuestion.question_text = question_text
        newQuestion.asker = asker
        newQuestion.answer_text = answer_text
        newQuestion.created_by = created_by
    }

}
