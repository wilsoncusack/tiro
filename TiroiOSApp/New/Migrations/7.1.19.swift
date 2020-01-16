//
//  7.1.19.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/7/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func fetchAllActivites() -> [Activity] {
    let activities: NSFetchRequest = Activity.fetchRequest()
    let result = try? AppDelegate.viewContext.fetch(activities)
    return result!
}

func fetchAllQuestions() -> [Question] {
    let fetch: NSFetchRequest = Question.fetchRequest()
    let result = try? AppDelegate.viewContext.fetch(fetch)
    return result!
}

func fetchAllToDos() -> [ToDo] {
    let fetch: NSFetchRequest = ToDo.fetchRequest()
    let result = try? AppDelegate.viewContext.fetch(fetch)
    return result!
}

func fetchAllLearners() -> [Learner] {
    let fetch: NSFetchRequest = Learner.allLearnersFetchRequest()
    let result = try? AppDelegate.viewContext.fetch(fetch)
    return result!
}


func migration1(){
    // iterate through each one
    // each date, check if todya has been created
    // if it has, save it to it
    // it hasn't, create
    let activities = fetchAllActivites()
    let questions = fetchAllQuestions()
    let toDos = fetchAllToDos()
    let learners = fetchAllLearners()
    
    var todayMap = [Date:Document]()
    var oldToNewLearnerMap = [Learner: User]()
    
    var daysFetch: NSFetchRequest<Document> = Document.fetchRequest()
    daysFetch.predicate = NSPredicate(format: "type_private == %@", "day")
    do{
        let days = try AppDelegate.viewContext.fetch(daysFetch)
        for d in days{
            todayMap[d.date.removeTimeStamp()] = d
        }
    } catch {
        print(error)
    }
    
    for l in learners{
        var image: Data?
        if(l.image == nil){
            image =  UIImage(imageLiteralResourceName: l.profile_image_name!).jpegData(compressionQuality: 0.8)
        } else {
            image = l.image
        }
        let new = User(birthday: nil, created_by: l.created_by, image: image, first_name: l.name, last_name: "")
        oldToNewLearnerMap[l] = new
    }
    
    for a in activities{
        let today: Document = todayMap[a.activity_date.removeTimeStamp()] ?? makeDay(date: a.activity_date, user: a.created_by)
        todayMap[a.activity_date] = today
        let newActivity = makeNewActivityFromOldActivity(activity: a, learnerMap: oldToNewLearnerMap)
        let newAsElement = Value.documentValue(value: DocumentValue(document: newActivity), displayType: .basic, editType: .basic)
        var _ = Document_Element(order: 0, value: newAsElement, type: .document, document: today)
    }
    
    for q in questions{
        let today: Document = todayMap[q.date_created.removeTimeStamp()] ?? makeDay(date: q.date_created, user: q.created_by)
        todayMap[q.date_created] = today
        let newActivity = makeNewQuestionFromOld(question: q, learnerMap: oldToNewLearnerMap)
        let newAsElement = Value.documentValue(value: DocumentValue(document: newActivity), displayType: .basic, editType: .basic)
        var _ = Document_Element(order: 0, value: newAsElement, type: .document, document: today)
    }
    
    for t in toDos{
        let today: Document = todayMap[t.date_created.removeTimeStamp()] ?? makeDay(date: t.date_created, user: t.createdBy)
        todayMap[t.date_created] = today
        let newActivity = makeNewToDosFromOld(toDo: t, learnerMap: oldToNewLearnerMap)
        let newAsElement = Value.documentValue(value: DocumentValue(document: newActivity), displayType: .basic, editType: .basic)
        var _ = Document_Element(order: 0, value: newAsElement, type: .document, document: today)
    }
    
}

func makeNewActivityFromOldActivity(activity: Activity, learnerMap: [Learner: User]) -> Document{
    let learners = activity.participants?.allObjects as! [Learner]
    var newLearners = [User]()
    for l in learners {
        newLearners.append(learnerMap[l]!)
    }
    let tags = activity.tags?.allObjects as! [Tag]
    
    let document = Document(title: "Activity Reflection", type: .activity, elements: nil, tags: activity.tags, associated_users: NSSet(array: newLearners), created_by: activity.created_by, date: activity.activity_date)
   

    var _ = makeTextViewElement(text: activity.title, placeholder: "Title", order: 0, editType: .shortText, displayView: .title, document: document)

    var _ = makeTextViewElement(text: activity.notes ?? "", placeholder: "notes...", order: 1, editType: .shortText, displayView: .text, document: document)
    makeIntElement(order: 2, editType: .minutes, displayType: .minutes, document: document)
    
    let image = Value.images(
        value: (activity.image != nil) ? [ImageWrapper(uiImage: UIImage(data: activity.image!)!)] : [],
        displayType: .mediumScroll, createType: .photoLibrary, editType: .images)
    var _ = Document_Element(order: 3, value: image, type: .images, document: document)
    
    var _ = makeUserPicker(selected: newLearners.map {$0.id.description}, order: 4, displayType: .participants, document: document)
    
    var _ = makeTagsPicker(selected: tags.map {$0.id.description}, order: 5, document: document)
    
    return document
}

func makeNewQuestionFromOld(question: Question, learnerMap: [Learner: User]) -> Document{
    let newLearners : [User] = (question.asker == nil) ? [] : [learnerMap[question.asker!]!]
    
     //let tags = question.tags?.allObjects as! [Tag]
     
     let document = Document(title: "Question", type: .question, elements: nil, tags: nil, associated_users: NSSet(array: newLearners), created_by: question.created_by, date: question.date_created)
    

    var _ = makeTextViewElement(text: question.question_text, placeholder: "Question...", order: 0, editType: .shortText, displayView: .quote, document: document)
    
    var _ = makeUserPicker(selected: newLearners.map {$0.id.description}, order: 1, displayType: .participants, document: document)

    var _ = makeTextViewElement(text: question.answer_text ?? "", placeholder: "Answer..", order: 2, editType: .shortText, displayView: .text, document: document)
     
     let image = Value.images(
         value: [],
         displayType: .mediumScroll, createType: .photoLibrary, editType: .images)
     var _ = Document_Element(order: 3, value: image, type: .images, document: document)
     
     
     
     var _ = makeTagsPicker(selected: [], order: 4, document: document)
     
     return document
}


func makeNewToDosFromOld(toDo: ToDo, learnerMap: [Learner: User]) -> Document{
   //let learners = (toDo.learner != nil) ? [toDo.learner!] : []
    let newLearners : [User] = (toDo.learner == nil) ? [] : [learnerMap[toDo.learner!]!]
    
    //? [] : [learnerMap[learners[0]]!]
    
       let tags = toDo.tags?.allObjects as! [Tag]
       
    let document = Document(title: "Activity Reflection", type: .toDo, elements: nil, tags: toDo.tags, associated_users: NSSet(array: newLearners), created_by: toDo.createdBy, date: toDo.date_created)
      

    var _ = makeTextViewElement(text: toDo.title, placeholder: "What to do...", order: 0, editType: .shortText, displayView: .text, document: document)

    var _ = makeBoolElement(value: toDo.done, order: 1, displayType: .ToDo, document: document)
       
   
      
       
       var _ = makeUserPicker(selected: newLearners.map {$0.id.description}, order: 2, displayType: .participants, document: document)
       
       var _ = makeTagsPicker(selected: tags.map {$0.id.description}, order: 3, document: document)
       
       return document

}


