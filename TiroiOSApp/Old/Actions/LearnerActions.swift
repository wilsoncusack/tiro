//
//  LearnerActions.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

func learnerReducer(state: inout LearnerState, action: LearnerAction){
    switch action{
    case let .create(name, image):
        //var _ =
        var _ = User(birthday: nil, created_by: state.loggedInUser, image: image, first_name: name, last_name: "")
        NotificationCenter.default.post(name: .learnerCreate, object: nil)
    case let .edit(learner, name, image):
        learner.objectWillChange.send()
        learner.name = name
        learner.image = image
        NotificationCenter.default.post(name: .learnerEdit, object: nil)
    }
    
}

enum LearnerAction{
    case create(name: String, image: Data?)
    case edit(learner: Learner, name: String, image: Data?)

    

   

    var edit: (learner: Learner, name: String, image: Data?)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(learner: newValue.0, name: newValue.1, image: newValue.2)
        }
    }

    var create: (name: String, image: Data?)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(name: newValue.0, image: newValue.1)
        }
    }
}

extension Learner {
    convenience init(
        id : UUID = UUID(),
        name : String,
        profile_image_name: String?,
        image: Data?,
        created_by: User
    ){
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.name = name
        self.profile_image_name = profile_image_name
        self.image = image
        self.created_by = created_by
    }
}
