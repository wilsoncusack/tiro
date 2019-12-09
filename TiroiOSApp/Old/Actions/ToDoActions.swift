//
//  ToDoActions.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/18/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

enum ToDoAction{
    case create(
        title: String,
        due_date: Date?,
        notes: String?,
        link: String?,
        learner: Learner?,
        notification_id: String?,
        tags: [Tag]
    )
    
    case edit(
        toDo: ToDo,
        title: String,
        due_date: Date?,
        notes: String?,
        link: String?,
        done: Bool = false,
        learner: Learner?,
        notification_id: String?,
        tags: [Tag],
        saved_to_activity: Bool
    )
    
    case editDone(toDo: ToDo, done: Bool)
    
    case editSavedToActivity(toDo: ToDo, saved: Bool)
    
    case activity(ActivityAction)



    var activity: ActivityAction? {
        get {
            guard case let .activity(value) = self else { return nil }
            return value
        }
        set {
            guard case .activity = self, let newValue = newValue else { return }
            self = .activity(newValue)
        }
    }

    var create: (
        title: String, 
        due_date: Date?, 
        notes: String?, 
        link: String?, 
        learner: Learner?, 
        notification_id: String?, 
        tags: [Tag])? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(
        title: newValue.0, 
        due_date: newValue.1, 
        notes: newValue.2, 
        link: newValue.3, 
        learner: newValue.4, 
        notification_id: newValue.5, 
        tags: newValue.6)
        }
    }

    var edit: (
        toDo: ToDo, 
        title: String, 
        due_date: Date?, 
        notes: String?, 
        link: String?, 
        done: Bool , 
        learner: Learner?, 
        notification_id: String?, 
        tags: [Tag], 
        saved_to_activity: Bool)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(
        toDo: newValue.0, 
        title: newValue.1, 
        due_date: newValue.2, 
        notes: newValue.3, 
        link: newValue.4, 
        done: newValue.5, 
        learner: newValue.6, 
        notification_id: newValue.7, 
        tags: newValue.8, 
        saved_to_activity: newValue.9)
        }
    }

    var editDone: (toDo: ToDo, done: Bool)? {
        get {
            guard case let .editDone(value) = self else { return nil }
            return value
        }
        set {
            guard case .editDone = self, let newValue = newValue else { return }
            self = .editDone(toDo: newValue.0, done: newValue.1)
        }
    }

    var editSavedToActivity: (toDo: ToDo, saved: Bool)? {
        get {
            guard case let .editSavedToActivity(value) = self else { return nil }
            return value
        }
        set {
            guard case .editSavedToActivity = self, let newValue = newValue else { return }
            self = .editSavedToActivity(toDo: newValue.0, saved: newValue.1)
        }
    }


    

    
}

struct ToDoState{
    var loggedInUser: User
    var activityState: ActivityState
}

extension AppState{
    var toDoState : ToDoState {
        get {
            ToDoState(loggedInUser: self.loggedInUser!, activityState: self.activityState)
        }
        set {
        
        }
    }
}

func toDoReducer(state: inout ToDoState, action: ToDoAction){
    switch action{
    
    case .create(let title, let due_date, let notes, let link, let learner, let notification_id, let tags):
        _ = ToDo(title: title, due_date: due_date, notes: notes, link: link, createdBy: state.loggedInUser, learner: learner, notification_id: notification_id, tags: NSSet(array: tags))
        NotificationCenter.default.post(name: .toDoCreate, object: nil)
        
    case .edit(let toDo, let title, let due_date, let notes, let link, let done, let learner, let notification_id, let tags, let saved_to_activity):
        toDo.title = title
        toDo.due_date = due_date
        toDo.notes = notes
        toDo.link = link
        toDo.done = done
        toDo.learner = learner
        toDo.notification_id = notification_id
        toDo.tags = NSSet(array: tags)
        toDo.saved_to_activity = saved_to_activity
        print("in edit")
        print("title: \(toDo.title)")
        for tag in tags{
            print(tag.name)
        }
        NotificationCenter.default.post(name: .toDoEdit, object: nil)
        
    case let .editDone(toDo, done):
        toDo.done = done
        NotificationCenter.default.post(name: .toDoEdit, object: nil)
        
    case let .editSavedToActivity(toDo, saved):
        toDo.saved_to_activity = saved
        NotificationCenter.default.post(name: .toDoSavedToActivity, object: nil)
    
    
    case let .activity(action):
    activityReducer(state: &state.activityState, action: action)
    }
}


extension Notification.Name{
    static let toDoCreate = Notification.Name("toDoCreate")
    static let toDoEdit = Notification.Name("toDoEdit")
    static let toDoSavedToActivity = Notification.Name("toDoSavedToActivity")
}
