//
//  QuestionList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuestionRow: View {
    @ObservedObject var question: Question
    
    var body: some View{
        VStack(alignment: .leading){
            Text(question.question_text)
                .padding(.top, 10)
                .padding(.bottom, 10)
            HStack{
                questionStatusText(question.answer_text)
                Spacer()
                if(question.asker != nil){
                    ProfileImage(learner: question.asker!, size: 30)
                    .padding(.trailing, 15)
                }
                
            }
             .padding(.bottom, 10)
//            Text(longDateFormatter.string(from:question.date_created))
//                .font(.footnote)
//                .foregroundColor(.secondary)
//                .padding(.bottom, 30)
        }
    }
}

struct QuestionList: View {
    @ObservedObject var store: Store<QuestionState, QuestionAction>
    var questions: [Question]
    
    var body: some View{
        List(questions){question in
            NavigationLink(destination: QuestionDetailView(store: self.store, question: question)){
                QuestionRow(question: question)
            }
        }
        .navigationBarTitle("Questions", displayMode: .inline)

    }
}
