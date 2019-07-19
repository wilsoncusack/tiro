//
//  DemoData1.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import CoreData

class DemoData : MainEnvObj {
//    var mainEnv : MainEnvObj
//    var user : User!
//    var learner : Learner!
//    var Activity : Activity!
    //let context = AppDelegate.viewContext
//    static var user = User(first_name: "Wilson", last_name: "Cusack")
//    static var learner = Learner(name: "Asher", created_by: user, profile_image_name: "rabbit")
//    static var learners = NSSet(object: learner)
//    public var activity = Activity(activity_date: Date(), title: "Test title", notes: "was great", created_by: user, participants: learners)
    
//    var questionStore : QuestionStore
//    var learners : [Learner]!
//    var user : User!
//
//
//    func createUser() -> User{
//        return User.create(first_name: "Wilson", last_name: "Cusack", in: context)
//    }
//
//    func getUser(first_name : String) -> User {
//        let request : NSFetchRequest<User> =  User.fetchRequest()
//        let predicate = NSPredicate(format : "first_name = %@", first_name)
//        request.predicate = predicate
//        let user = try? context.fetch(request)[0]
//        return user!
//
//    }
//
//
//
//    func createLearners(user : User) -> [Learner] {
//        let l = ["Lux", "Joan", "Alma"]
//        //return [Learner.create(name: "Lux", created_by: user, in: context)]
//        return l.map {Learner.create(name: $0, created_by: user, in: context)}
//
//    }
//
//    func deleteLearners() {
//        let request : NSFetchRequest<Learner> =  Learner.fetchRequest()
//        let learners : [Learner]? = try? context.fetch(request)
//        if(learners != nil){
//            learners!.map {context.delete($0)}
//        }
//
//    }
//
//    func deleteUser(){
//        let request : NSFetchRequest<User> =  User.fetchRequest()
//        let users : [User]? = try? context.fetch(request)
//        if(users != nil){
//            if(users!.count > 1){
//                print("deleting multiple user")
//            }
//            users!.map {context.delete($0)}
//        }
//    }
//
//    func getLearners() -> [Learner] {
//        let learners = try? context.fetch(Learner.fetchRequest())
//        return learners as! [Learner]
//    }
    
    override init(){
        super.init()
        if(super.userStore.user != nil){
            super.deleteUser()
        }
        if(super.learnerStore.learners.count > 0){
            for learner in  super.learnerStore.learners{
                super.deleteLearner(learner: learner)
            }
        }
        if(super.activityStore.activities.count > 0){
            for activity in super.activityStore.activities{
                super.deleteActivity(activity: activity)
            }
        }
        super.createUser(first_name: "Wilson", last_name: "Cusack")
       super.userStore.user!.has_finished_setup = true
        super.createLearner(name: "Asher", profile_image_name: "rabbit")
        super.createLearner(name: "Lux", profile_image_name: "red-oragami")
        super.createLearner(name: "Joan", profile_image_name: "multi-oragami")
        super.createActivity(activity_date: Date(), title: "Test Title", notes: "This was a fun game where we used a bridge (?) beg board to race pegs. Each turn, you just roll and die and move your piece that number. Good for counting practice. ", image_name: "pegRace", participants: super.learnerStore.learners)
        super.createActivity(activity_date: Date(), title: "Another activity with a longer title", notes: "This was a fun game where we used a bridge (?) beg board to race pegs. Each turn, you just roll and die and move your piece that number. Good for counting practice. ", image_name: "pegRace", participants: [super.learnerStore.learners[0]])
//        self.mainEnv = MainEnvObj()
//        self.user = mainEnv.userStore.user
       // self.learners = mainEnv.learnerStore.learners

    }
//
//    private func saveChanges() {
//        guard context.hasChanges else { return }
//        do {
//            try context.save()
//        } catch { fatalError() }
//    }
    
    
    
    deinit {
        print("deleting")
       super.deleteUser()
        
        for learner in  super.learnerStore.learners{
            super.deleteLearner(learner: learner)
        }
        for activity in super.activityStore.activities{
            super.deleteActivity(activity: activity)
        }
        //super.activityStore.activities.map {super.deleteActivity(activity: $0)}
        
    }
    
    
}
