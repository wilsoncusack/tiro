//
//  QuestionActions.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

func questionReducer(state: inout QuestionState, action: QuestionAction){
    switch action{
    case let .create(questionText, answerText, asker):
        var _ = Question(question_text: questionText, answer_text: answerText, asker: asker, created_by: state.loggedInUser)
        // AppDelegate.shared.saveContext()
        NotificationCenter.default.post(name: .questionCreate, object: nil)
    case let .edit(questionText, answerText, asker, question):
        question.objectWillChange.send()
        question.question_text = questionText
        question.asker = asker
        question.answer_text = answerText
        NotificationCenter.default.post(name: .questionEdit, object: nil)
        //AppDelegate.shared.saveContext()
    }
}

enum QuestionAction{
    case create(questionText: String, answerText: String?, asker: Learner)
    case edit(questionText: String, answerText: String?, asker: Learner, question: Question)

    var create: (questionText: String, answerText: String?, asker: Learner)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(questionText: newValue.0, answerText: newValue.1, asker: newValue.2)
        }
    }

    var edit: (questionText: String, answerText: String?, asker: Learner, question: Question)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(questionText: newValue.0, answerText: newValue.1, asker: newValue.2, question: newValue.3)
        }
    }

}
