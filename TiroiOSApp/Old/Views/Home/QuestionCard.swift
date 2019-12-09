//
//  QuestionCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/29/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//func questionStatusText(_ answer: String?) -> Text{
//    if(answer == nil || answer!.isEmpty){
//      return  Text("Not Answered")
//            .foregroundColor(.orange)
//    } else {
//       return Text("Answered")
//        .foregroundColor(.green)
//    }
//}

struct QuestionCard: View {
    @ObservedObject var question: Question
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text(question.question_text)
                    .frame(width: 235, height: 45)
                    .lineLimit(1)
                    

            }.padding(.bottom, 15)
            HStack{
                if(question.asker != nil){
                Text(question.asker!.name)
                    .bold()
                }
                Spacer()
                questionStatusText(question.answer_text)

            }
        }.frame(width: 235, height: 80)
        .padding()
        .background(Color(red: 1, green: 0.9843137255, blue: 0.9411764706))
            .cornerRadius(8)
            .padding(.top, 8).padding(.bottom, 8)
    }
}

