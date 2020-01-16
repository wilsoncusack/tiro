//
//  ActivityActions.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

func activityReducer(state: inout ActivityState, action: ActivityAction){
    switch action{
    case let .create(activityDate, title, image, link, notes, tags, participants):
        var _ = Activity(activity_date: activityDate, title: title, image: image, link: link, notes: notes, created_by: state.loggedInUser, tags: NSSet(array: tags), participants: NSSet(array: participants))
        NotificationCenter.default.post(name: .activityCreate, object: nil)
    case let .edit(activityDate, title, image, link, notes, tags, participants, activity):
        print("in activity edit")
        activity.objectWillChange.send()
        activity.activity_date = activityDate
        activity.title = title
        activity.link = link
        activity.notes = notes
        activity.tags = NSSet(array: tags)
        activity.participants = NSSet(array: participants)
        activity.image = image
        NotificationCenter.default.post(name: .activityEdit, object: nil)
    }
}

enum ActivityAction{
    case create(activityDate: Date, title: String, image: Data?, link: String?, notes: String?, tags: [Tag], participants: [Learner])
    case edit(activityDate: Date, title: String, image: Data?, link: String?, notes: String?, tags: [Tag], participants: [Learner], activity: Activity)

    var create: (activityDate: Date, title: String, image: Data?, link: String?, notes: String?, tags: [Tag], participants: [Learner])? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(activityDate: newValue.0, title: newValue.1, image: newValue.2, link: newValue.3, notes: newValue.4, tags: newValue.5, participants: newValue.6)
        }
    }

    var edit: (activityDate: Date, title: String, image: Data?, link: String?, notes: String?, tags: [Tag], participants: [Learner], activity: Activity)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(activityDate: newValue.0, title: newValue.1, image: newValue.2, link: newValue.3, notes: newValue.4, tags: newValue.5, participants: newValue.6, activity: newValue.7)
        }
    }


}

extension Activity {
    
    convenience init(
        id: UUID = UUID(),
        date_created : Date = Date(),
        activity_date: Date,
        title: String,
        image: Data?,
        link: String?,
        notes: String?,
        created_by: User,
        tags: NSSet?,
        participants : NSSet)
    {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.date_created = date_created
        self.activity_date = activity_date
        self.title = title
        self.image = image
        self.link = link
        self.notes = notes
        self.created_by = created_by
        self.tags = tags
        self.participants = participants
    }
    
}

