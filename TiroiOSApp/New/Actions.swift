////
////  Actions.swift
////  TiroiOSApp
////
////  Created by Wilson Cusack on 9/19/19.
////  Copyright © 2019 Wilson Cusack. All rights reserved.
////
//
//import Foundation
//
//struct AppState {
//    var learners: [LocalLearner] = []
//}
//
//struct LearnerState {
//    var learners: [LocalLearner]
//}
//
////enum LearnerAction {
////    case create(id: Int, name: String)
////    case delete
////    case edit
////}
////
////enum UserEditAction {
////    case changeName
////}
////
////enum UserAction {
////    case create
////    case delete
////    case edit(UserEditAction)
////}
////
////enum AppAction {
////    case learner(LearnerAction)
////    case user(UserAction)
////}
//
//func combine<Value, Action>(
//    _ reducers: (inout Value, Action) -> Void...
//) -> (inout Value, Action) -> Void{
//    return {value, action in
//        for reducer in reducers {
//           reducer(&value, action)
//        }
//    }
//}
//
//struct LocalLearner {
//    var id: Int
//    var name: String
//}
//
//func learnerReducer(state: inout LearnerState, action: LearnerAction){
//    switch action{
//    case let .create(id, name):
//        state.learners.append(.init(id: id, name: name))
//    case .delete:
//        fatalError()
//    case .edit:
//        fatalError()
//    default:
//        break
//    }
//}
//
//func userReducer(state: inout AppState, action: AppAction){
//    switch action{
//    case .user(.create):
//        fatalError()
//    case .user(.delete):
//        fatalError()
//    case .user(.edit):
//        fatalError()
//    default:
//        break
//    }
//}
//
//
//
//func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
//    _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
//    value: WritableKeyPath<GlobalValue, LocalValue>,
//    action: WritableKeyPath<GlobalAction, LocalAction?>
//    ) -> (inout GlobalValue, GlobalAction) -> Void {
//
//      return  { globalValue, globalAction in
//        guard let localAction = globalAction[keyPath: action] else { return }
//        reducer(&globalValue[keyPath: value], localAction)
//      }
//    }
//
//extension AppState {
//    var learnersState: LearnerState {
//        get{
//            LearnerState(learners: self.learners)
//        }
//        set {
//            self.learners = newValue.learners
//        }
//    }
//}
//
//let _appReducer = combine(
//    pullback(learnerReducer, value: \.learnersState, action: \.learner),
//    userReducer)
//
//let appReducer = pullback(_appReducer, value: \.self, action: \.self)
