//
//  Main.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

struct Icon : Identifiable {
    var id : Int
    var image : String
}

class MainEnvObj : ObservableObject {
    
    private let persistenceManager = PersistenceManager()
    
    @Published var userStore = UserStore()
    @Published var learnerStore = LearnerStore()
    @Published var activityStore = ActivityStore()
    @Published var questionStore = QuestionStore()
    @Published var tagStore = TagStore()
    @Published var tagTypeStore = TagTypeStore()
    
    @Published var setupShowUserCreation = true
    @Published var setupShowLearnerCreation = true
   // @Published var tagCounts : [ActivityStore.TagCount] = []
    
    //@Published var mostCommonTagsLastSevenDays : [(Tag, Int)]!
    

    
    //@Published var userSetupComplete : Bool
    
    
    
    var icons : [Icon] = [
        Icon(id: 1, image: "dog"),
        Icon(id: 2, image: "rabbit"),
        Icon(id: 3, image: "multi-oragami"),
        Icon(id: 4, image: "red-oragami")
    ]
    
    init(){
        
        if(tagTypeStore.tagTypes.count == 0){
            tagTypeStore.create(name: "Subject")
        }
        if(tagStore.tags.count == 0){
            tagStore.create(name: "math", tag_type: tagTypeStore.tagTypes[0])
            tagStore.create(name: "science", tag_type: tagTypeStore.tagTypes[0])
            tagStore.create(name: "reading", tag_type: tagTypeStore.tagTypes[0])
            tagStore.create(name: "writing", tag_type: tagTypeStore.tagTypes[0])
            tagStore.create(name: "history", tag_type: tagTypeStore.tagTypes[0])
            tagStore.create(name: "foreign language", tag_type: tagTypeStore.tagTypes[0])
        }
        if((tagStore.tags.filter {$0.name == "history"}).count == 0){
           tagStore.create(name: "history", tag_type: tagTypeStore.tagTypes[0])
            tagStore.create(name: "foreign language", tag_type: tagTypeStore.tagTypes[0])
        }
        if(userStore.user != nil){
            self.setupShowUserCreation = false
        }
        if(learnerStore.learners.count > 0){
            self.setupShowLearnerCreation = false
        }
        //tagCounts = activityStore.tags
    }
    
//    public var tagCounts : [ActivityStore.TagCount] {
//        activityStore.tags
//    }
    

    
    
    //MARK: user
    
    public func deleteUser(){
        self.userStore.delete()
    }
    
    public func createUser(first_name: String, last_name : String) {
        self.userStore.create(first_name: first_name, last_name: last_name)
        
    }
    
    public func userFinishedSetup(){
        self.setupShowLearnerCreation = false
        self.userStore.user?.has_finished_setup = true
    }
    
    public func createLearner(name : String, profile_image_name : String?, image: Data?){
        self.learnerStore.create(name: name, created_by: userStore.user!, profile_image_name : profile_image_name, image: image)
    }
    
    public func deleteLearner(learner : Learner) {
        self.learnerStore.delete(learner: learner)
    }
    
    
    //MARK: activity
    
    public func createActivity(activity_date : Date, title: String, notes: String?, image: Data?, image_name: String?, participants : [Learner], tags: [Tag]) {
        self.activityStore.create(activity_date: activity_date, title: title, notes: notes, image: image, created_by: userStore.user!, image_name: image_name, participants: NSSet(array: participants), tags: NSSet(array: tags))
    }
    
    
    public func deleteActivity(activity : Activity) {
        self.activityStore.delete(activity: activity)
    }
    
    func createBindablefromActivity(activity : Activity) -> ActivityBindable{
        return ActivityBindable(
            title: activity.title ?? "",
            notes: activity.notes,
            activityDate: activity.activity_date,
            image: activity.image,
            participants: (activity.participants != nil ? activity.participants!.sortedArray(using: [NSSortDescriptor(key: "name", ascending: false)]) : [])  as! [Learner],
            tags: (activity.tags != nil ? activity.tags!.sortedArray(using: [NSSortDescriptor(key: "name", ascending: false)])  : []) as! [Tag]
        )
    }
    
    func saveActivityFromBindable(bindableActivity: ActivityBindable, activity : Activity){
            activity.title = bindableActivity.title
            activity.activity_date = bindableActivity.activityDate
            activity.notes = bindableActivity.notes.isEmpty ? nil : bindableActivity.notes
            activity.participants = NSSet(array: bindableActivity.participants)
        activity.tags = NSSet(array: bindableActivity.tags)
            activity.image = bindableActivity.image
        activityStore.saveChanges()
        activity.objectWillChange.send()
    }
        
    func createActivtyFromBindable(bindable : ActivityBindable) {
        createActivity(
            activity_date: bindable.activityDate,
            title: bindable.title,
            notes: bindable.notes,
            image: bindable.image,
            image_name: nil,
            participants: bindable.participants,
            tags: bindable.tags
        )
    }
    
    
    //MARK: question
    
    func createQuestion(question: String, asker: Learner, answer: String?){
        questionStore.create(question_text: question, asker: asker, answer_text: answer, created_by: userStore.user!)
    }
    
    
    func createBindablefromQuestion(question : Question) -> QuestionBindable{
        return QuestionBindable(question_text: question.question_text, asker: question.asker, answer_text: question.answer_text)
    }
    
    func saveQuestionFromBindable(bindableQuestion: QuestionBindable, question : Question){
        question.question_text = bindableQuestion.question_text
        if(bindableQuestion.asker != nil){
            question.asker = bindableQuestion.asker!
        }
        question.answer_text = (bindableQuestion.answer_text == "" ? nil : bindableQuestion.answer_text)
        questionStore.saveChanges()
    }
        
    func createQuestionFromBindable(bindable : QuestionBindable) {
        if bindable.asker == nil {
            return
        }
        createQuestion(question: bindable.question_text, asker: bindable.asker!, answer: (bindable.answer_text == "" ? nil : bindable.answer_text))
    }
   
    

    
}
