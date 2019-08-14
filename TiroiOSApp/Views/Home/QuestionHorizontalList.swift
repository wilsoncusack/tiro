//
//  QuestionHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/31/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuestionHorizontalList: View {
    @EnvironmentObject var mainEnv: MainEnvObj
    @Binding var showModal : Bool
    @Binding var modalKind: String
    @Binding var question: Question?
    
    var body: some View {
        VStack(alignment: .leading){
        HStack {
            Text("Questions")
                .font(.system(size: 22))
                .bold()
                .padding(.leading, 15)
            
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 10){
                ForEach(mainEnv.questionStore.questions){question in
                    QuestionCard(question: question.question_text, answer: question.answer_text, learner: question.asker)
                        .onTapGesture {
                            self.showModal = true
                            self.question = question
                            self.modalKind = "question"
                    }
                }
            }.frame(height:125).padding(.leading, 15).padding(.trailing, 15)
        }
        }.padding(.bottom,20)
    }
}

#if DEBUG
//struct QuestionHorizontalList_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionHorizontalList()
//    }
//}
#endif
