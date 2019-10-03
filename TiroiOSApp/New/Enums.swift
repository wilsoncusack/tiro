////
////  Test.swift
////  TiroiOSApp
////
////  Created by Wilson Cusack on 9/22/19.
////  Copyright © 2019 Wilson Cusack. All rights reserved.
////
//
//import Foundation
//
//enum LearnerAction {
//    case create(id: Int, name: String)
//    case delete
//    case edit
//
//    var create: (id: Int, name: String)? {
//        get {
//            guard case let .create(value) = self else { return nil }
//            return value
//        }
//        set {
//            guard case .create = self, let newValue = newValue else { return }
//            self = .create(id: newValue.0, name: newValue.1)
//        }
//    }
//
//    var delete: Void? {
//        guard case .delete = self else { return nil }
//        return ()
//    }
//
//    var edit: Void? {
//        guard case .edit = self else { return nil }
//        return ()
//    }
//}
//
//enum UserEditAction {
//    case changeName
//}
//
//enum UserAction {
//    case create
//    case delete
//    case edit(UserEditAction)
//
//    var create: Void? {
//        guard case .create = self else { return nil }
//        return ()
//    }
//
//    var delete: Void? {
//        guard case .delete = self else { return nil }
//        return ()
//    }
//
//    var edit: UserEditAction? {
//        get {
//            guard case let .edit(value) = self else { return nil }
//            return value
//        }
//        set {
//            guard case .edit = self, let newValue = newValue else { return }
//            self = .edit(newValue)
//        }
//    }
//}
//
//enum AppAction {
//    case learner(LearnerAction)
//    case user(UserAction)
//
//    var learner: LearnerAction? {
//        get {
//            guard case let .learner(value) = self else { return nil }
//            return value
//        }
//        set {
//            guard case .learner = self, let newValue = newValue else { return }
//            self = .learner(newValue)
//        }
//    }
//
//    var user: UserAction? {
//        get {
//            guard case let .user(value) = self else { return nil }
//            return value
//        }
//        set {
//            guard case .user = self, let newValue = newValue else { return }
//            self = .user(newValue)
//        }
//    }
//}
