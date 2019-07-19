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

class MainEnvObj : BindableObject {
   // typealias PublisherType = type
    
    private let persistenceManager = PersistenceManager()
     let willChange = PassthroughSubject<Void, Never>()
    
    var userStore = UserStore()
    var learnerStore = LearnerStore()
    var activityStore = ActivityStore()
    

    
    var userSetupComplete : Bool {
        return userStore.user != nil
        
    }
    var icons = ["dog", "rabbit", "multi-oragami", "red-oragami"]
    
    init(){
        
    }
    
    public func deleteUser(){
       willChange.send()
        self.userStore.delete()
       
    }
    
    public func createUser(first_name: String, last_name : String) {
        willChange.send()
        self.userStore.create(first_name: first_name, last_name: last_name)
        
    }
    
    public func userFinishedSetup(){
        willChange.send()
        self.userStore.user?.has_finished_setup = true
    }
    
    public func createLearner(name : String, profile_image_name : String?){
       willChange.send()
        self.learnerStore.create(name: name, created_by: userStore.user!, profile_image_name : profile_image_name)
    }
    
    public func deleteLearner(learner : Learner) {
        willChange.send()
        self.learnerStore.delete(learner: learner)
    }
    
    public func createActivity(activity_date : Date, title: String, notes: String?, image_name: String?, participants : [Learner]) {
        willChange.send()
        self.activityStore.create(activity_date: activity_date, title: title, notes: notes, created_by: userStore.user!, image_name: image_name, participants: NSSet(array: participants))
    }
    
    public func deleteActivity(activity : Activity) {
        willChange.send()
        self.activityStore.delete(activity: activity)
    }
    
   
    

    
}
