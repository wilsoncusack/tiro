//
//  QuestionBindable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/31/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine



struct QuestionEditableForm : View {
    @ObservedObject var store: Store<QuestionState, QuestionAction>
    
   
    var question: Question?
    @State var questionText: String
    @State var answerText: String
    @State var asker: Learner?
    var done : () -> Void
    
    //var actions = {AppAction.question($0)}
    
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
       var learners: FetchedResults<Learner>
     @Environment(\.presentationMode) var presentationMode
    
    func save() {
        //QuestionAction.create(questionText: <#T##String#>, answerText: <#T##String?#>, asker: <#T##Learner#>)
        if(question != nil){
        
        store.send(.edit(questionText: self.questionText, answerText: self.answerText, asker: self.asker!, question: self.question!))
        } else {
            store.send(.create(questionText: questionText, answerText: answerText, asker: asker!))
        }
        
       
        self.presentationMode.wrappedValue.dismiss()
        self.done()
        
    }
    
    
    var body : some View {
        Form{
            TextField("Question", text: $questionText)
            SingleSelect(title: "Who asked?", chosen: $asker, choices: learners.map {$0}, getName: {learner in learner.name})
            Section(header: Text("You can fill this in later 😃")){
                TextField("Answer", text: $answerText)
            }
            
        }
        .navigationBarItems(
            trailing:
            Button(action: {
                if(self.questionText.isEmpty || self.asker == nil){
                    return
                }
                self.save()
                
            }){
                Text("Save")
                    .foregroundColor((self.questionText.isEmpty || self.asker == nil) ? Color.gray : Color.blue)
            }
        )
    }
}

//typealias QuestionStateTest = (loggedInUser: User, questionEditable: QuestionBindable)

struct QuestionCreateDetailView : View {
    //@EnvironmentObject var mainEnv : MainEnvObj
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    
    @ObservedObject var store : Store<QuestionState, QuestionAction>
    var question : Question?
    var done : () -> Void
    
    var questionText : String
    var answerText : String
    var asker: Learner?
    
    init(store: Store<QuestionState, QuestionAction>, question: Question?,  done: @escaping () -> Void){
        self.store = store
        self.done = done
        self.questionText = ""
        self.answerText = ""
        self.asker = nil
        if(question != nil){
            self.question = question
            self.questionText = question!.question_text
            self.answerText = question!.answer_text ?? ""
            self.asker = question!.asker
        }
    }
    
    
    var body: some View {
        
        QuestionEditableForm(store: self.store, question: question, questionText: self.questionText, answerText: self.answerText, asker: self.asker, done: self.done)
            .navigationBarTitle("\(question != nil ? "Edit" : "Create") Question", displayMode: .inline)
        
        
    }
}

