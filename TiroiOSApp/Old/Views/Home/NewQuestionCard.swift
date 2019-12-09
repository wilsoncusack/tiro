//
//  NewQuestionCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/5/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

func questionStatusText(_ answer: String?) -> Text{
    if(answer == nil || answer!.isEmpty){
      return  Text("Not Answered")
            .foregroundColor(.orange)
    } else {
       return Text("Answered")
        .foregroundColor(.green)
    }
}

struct NewQuestionCard: View {
    @ObservedObject var question: Question
    
    var isAnswered: Bool {
        question.answer_text != nil && !question.answer_text!.isEmpty
    }
    var body: some View {
        Rectangle()
            .frame(width: 250, height: 110)
            .foregroundColor(.clear)
            //.background(Color(red: 1, green: 0.9843137255, blue: 0.9411764706))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.3))
            .overlay(
                Text(question.question_text).padding()
                .lineLimit(2)
                    .foregroundColor(.primary)
                ,alignment: .topLeading)
            .overlay(
                HStack(alignment: .center){
                    Text(isAnswered ? "Answered" : "Not Answered")
                        .foregroundColor(isAnswered ? .green : .orange)
                    Spacer()
                    if(question.asker != nil){
                    ProfileImage(learner: question.asker!, size: 30)
                    }
                }.padding(.leading, 15).padding(.trailing, 15).padding(.bottom, 15)
                ,alignment: .bottomLeading)
            .padding(.top,1)
            .padding(.bottom,1)
    }
}
