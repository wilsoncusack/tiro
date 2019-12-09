//
//  AppState.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 9/19/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import CoreData






/// should probably constrain the state view for these
func userReducer(state: inout AppState, action: UserAction){
    switch action{
    case let .create(firstName, lastName):
        let user = User(first_name: firstName, last_name: lastName)
        state.loggedInUser = user
        NotificationCenter.default.post(name: .userCreate, object: nil)
    }
}

func setupReducer(state: inout AppState, action: SetupAction){
    switch action{
    case .finish:
        state.userHasFinishedSetup = true
        NotificationCenter.default.post(name: .finishSetup, object: nil)
    }
}

func tagReducer(state: inout AppState, action: TagAction){
    switch action{
    case let .create(name, tagType):
        var _ = Tag(name: name, tag_type: tagType)
        NotificationCenter.default.post(name: .tagCreate, object: nil)
    }
}

struct QuestionState{
    var loggedInUser: User
}

struct ActivityState{
    var loggedInUser: User
}

struct LearnerState {
    var loggedInUser: User
}

public struct Log{
    var time = Date()
    var action : String
    var anonID: UUID
}


public class AppState: ObservableObject {
    @Published var loggedInUser: User?
    @Published var userHasFinishedSetup = true
    
    @Published var reportingProfile : AnonymousProfile?
    
    public var sessionLog = [Log]()
    
    //@Published var questionEditable = QuestionBindable(question_text: "", asker: nil, answer_text: nil)
    
    init(){
        let userFetch = NSFetchRequest<User>(entityName: "User")
        do {
            let fetchedUsers = try AppDelegate.viewContext.fetch(userFetch)
            if(fetchedUsers.count != 0){
                loggedInUser = fetchedUsers[0]
                checkNewTags()
            } else {
                print("```in else to creat first tags```")
                createFirstTags()
            }
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
        
        let learnerFetch = NSFetchRequest<Learner>(entityName: "Learner")
        do {
            let fetchLearners = try AppDelegate.viewContext.fetch(learnerFetch)
            if(fetchLearners.count == 0){
                userHasFinishedSetup = false
            } else {
                
            }
        } catch {
            fatalError("Failed to fetch learners: \(error)")
        }
        setAnonymousProfile()
        makeLogger()
    }
    
    
    func makeLogger(){
        NotificationCenter.default.addObserver(forName: .questionEdit, object: nil, queue: nil, using: {notifcation in
           // self.sessionLog.append(Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
            logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .questionCreate, object: nil, queue: nil, using: {notifcation in
            logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .activityCreate, object: nil, queue: nil, using: {notifcation in
            logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .activityEdit, object: nil, queue: nil, using: {notifcation in
          logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .learnerCreate, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .learnerEdit, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .userCreate, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .finishSetup, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .tagCreate, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .toDoCreate, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .toDoEdit, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
        NotificationCenter.default.addObserver(forName: .toDoSavedToActivity, object: nil, queue: nil, using: {notifcation in
           logSingle(log: Log(action: notifcation.name.rawValue, anonID: self.reportingProfile!.id))
        })
    }
    
    func setAnonymousProfile(){
        let fetch = NSFetchRequest<AnonymousProfile>(entityName: "AnonymousProfile")
        do {
            let results = try AppDelegate.viewContext.fetch(fetch)
            if(results.count != 0){
                print("setting here")
                self.reportingProfile = results[0]
                AppDelegate.shared.saveContext()
            } else {
                self.reportingProfile = AnonymousProfile(id: UUID())
                print("setting new")
                AppDelegate.shared.saveContext()
            }
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
        
    }
    
}



func checkNewTags(){
    let tagFetch = NSFetchRequest<Tag>(entityName: "Tag")
    tagFetch.predicate = NSPredicate(format: "name == %@", "history")
    
    let tagTypeFetch = NSFetchRequest<TagType>(entityName: "Tag_Type")
    tagTypeFetch.predicate = NSPredicate(format: "name == %@", "Subject")
    do {
        let fetchedTags = try AppDelegate.viewContext.fetch(tagFetch)
        let fetchtedTagType = try AppDelegate.viewContext.fetch(tagTypeFetch)
        if(fetchedTags.count == 0){
            var _ = Tag(name: "history", tag_type: fetchtedTagType[0])
            var _ = Tag(name: "foreign language", tag_type: fetchtedTagType[0])
            AppDelegate.shared.saveContext()
        } else {
            
        }
    } catch {
        fatalError("Failed to fetch tags: \(error)")
    }
    
}

func createFirstTags(){
    let tagFetch = NSFetchRequest<Tag>(entityName: "Tag")
    do{
    let tags = try AppDelegate.viewContext.fetch(tagFetch)
        if(tags.count == 0 ){
            print("creating first tags")
            let subjectType = TagType(name: "Subject")
            var _ = Tag(name: "math", tag_type: subjectType)
            var _ = Tag(name: "science", tag_type: subjectType)
            var _ = Tag(name: "reading", tag_type: subjectType)
            var _ = Tag(name: "writing", tag_type: subjectType)
            var _ = Tag(name: "history", tag_type: subjectType)
            var _ = Tag(name: "foreign language", tag_type: subjectType)
            AppDelegate.shared.saveContext()
        }
    } catch {
        print(error)
    }
    
}

extension Notification.Name{
    static let questionCreate = Notification.Name("questionCreate")
    static let questionEdit = Notification.Name("questionEdit")
    static let activityCreate = Notification.Name("activityCreate")
    static let activityEdit = Notification.Name("activityEdit")
    static let learnerCreate = Notification.Name("learnerCreate")
    static let learnerEdit = Notification.Name("learnerEdit")
    static let userCreate = Notification.Name("userCreate")
    static let finishSetup = Notification.Name("finishSetup")
    static let tagCreate = Notification.Name("tagCreate")
}






extension AppState{
    var learnerState: LearnerState {
        get{
            LearnerState(loggedInUser: self.loggedInUser!)
        }
        set{
            
        }
    }
}

struct TagState{
    
}

extension AppState{
    var tagState: TagState {
        get{
            TagState()
            //LearnerState(loggedInUser: self.loggedInUser!)
        }
        set{
            
        }
    }
}

extension AppState{
    var activityState: ActivityState {
        get{
            ActivityState(loggedInUser: self.loggedInUser!)
        }
        set{
            
        }
    }
}

extension AppState{
    var questionState: QuestionState {
        get{
            QuestionState(loggedInUser: self.loggedInUser!)
        }
        set{
            //self.questionEditable = newValue.questionEditable
        }
    }
}




func appReducer(appState: inout AppState, appAction: AppAction){
    // guard let localAction = appAction[keyPath: action] else { return }
    _appReducer(&appState, appAction)
    AppDelegate.shared.saveContext()
}

let _appReducer: (inout AppState, AppAction) -> Void = combine(
    pullback(learnerReducer, value: \.learnerState, action: \.learner),
    pullback(questionReducer, value: \.questionState, action: \.question),
    pullback(activityReducer, value: \.activityState, action: \.activity),
    pullback(userReducer, value: \.self, action: \.user),
    pullback(setupReducer, value: \.self, action: \.setup),
    pullback(tagReducer, value: \.self, action: \.tag),
    pullback(toDoReducer, value: \.toDoState, action: \.toDo)
)

var systemProfileIcons : [Icon] = [
    Icon(id: 1, image: "dog"),
    Icon(id: 2, image: "rabbit"),
    Icon(id: 3, image: "multi-oragami"),
    Icon(id: 4, image: "red-oragami")
]

struct Icon : Identifiable {
    var id : Int
    var image : String
}

