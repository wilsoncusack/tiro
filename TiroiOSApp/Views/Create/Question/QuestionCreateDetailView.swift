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
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    var question : Question?
    @ObservedObject var questionBindable : QuestionBindable
    var done : () -> Void
    @Environment(\.presentationMode) var presentationMode
    @State var learnerSelection = 0
    @State var answerText = ""
    
    func save() {
        
        questionBindable.asker = mainEnv.learnerStore.learners[learnerSelection]
        if question != nil {
            mainEnv.saveQuestionFromBindable(bindableQuestion: questionBindable, question: question!)
        } else {
            mainEnv.createQuestionFromBindable(bindable: questionBindable)
        }
        self.showModal = false
       self.presentationMode.value.dismiss()
       self.done()
        
        
    }
    
    func getLearner(name: String) -> Learner {
        (mainEnv.learnerStore.learners.filter {$0.name == name})[0]
    }
    
    var body : some View {
        Form{
            TextField("Question", text: $questionBindable.question_text)
            Picker("Who asked?", selection: $learnerSelection) {
                ForEach(0 ..< mainEnv.learnerStore.learners.count){
                    Text(self.mainEnv.learnerStore.learners[$0].name).tag($0)
                }
            }
            Section(header: Text("You can fill this in later 😃")){
                TextField("Answer", text: $questionBindable.answer_text)
            }
            
        }
        .navigationBarItems(
            trailing:
            Button(action: {
                self.save()
               
            }){
                Text("Save")
            }
        )
    }
}

struct QuestionCreateDetailView : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    var question : Question?
    var done : () -> Void
    
    
    var questionBindable : QuestionBindable {
        if question != nil {
            return mainEnv.createBindablefromQuestion(question: question!)
        } else {
            return QuestionBindable(question_text: "", asker: nil, answer_text: nil)
        }
    }
    
    
    var body: some View {
        
        QuestionEditableForm(showModal: $showModal, question: question, questionBindable: questionBindable,  done: done)
            
            .navigationBarTitle("\(question != nil ? "Edit" : "Create") Question", displayMode: .inline)
        
        
    }
}

