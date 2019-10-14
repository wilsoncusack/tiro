//
//  QuestionDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/31/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuestionDetailView: View {
    @ObservedObject var store: Store<QuestionState, QuestionAction>
    @ObservedObject var question : Question
    
    var body: some View {
        ScrollView{
        VStack(alignment: .leading){
           
                Text(question.question_text)
                    .font(.system(size: 22))
                    .lineLimit(nil)
                    .padding(.bottom, 20)
                Spacer()
                HStack{
                    if(question.asker != nil){
                        ProfileImage(learner: question.asker!, size: 50)
                        Text(question.asker!.name)
                            .fontWeight(.bold)
                    }
                }
            
            
        
            Divider()
            VStack(alignment: .leading){
            Text("Answer")
                .font(.system(size: 34))
                .fontWeight(.bold)
                .padding(.bottom, 15)

            Text(question.answer_text ?? "Not answered")
                .foregroundColor(question.answer_text != nil ? .primary : .secondary )
                .lineLimit(nil)
                
            
            
        }
        }.padding(.leading, 15)
            }
        .navigationBarTitle("Question", displayMode: .large)
            .navigationBarItems(trailing:
//        NavigationLink(destination: QuestionCreateDetailView(question: question, done: {}))
                NavigationLink(destination: QuestionCreateDetailView(store: store, question: question, done: {}))
        {
        Text("Edit")
            })
    }
        
}

