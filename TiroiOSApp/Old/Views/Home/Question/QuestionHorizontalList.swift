//
//  QuestionHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuestionHorizontalList: View {
    @ObservedObject var store: Store<QuestionState, QuestionAction>
    var questions: [Question]
    
    var body: some View {
        VStack{
        HStack{
            SectionTitle("Questions")
            Spacer()
            NavigationLink(destination: QuestionList(store: store, questions: questions)){
                Text("See All")
            }.padding(.trailing, 15)
        }
            HorizontalScrollList(items: questions, card: {question in NewQuestionCard(question: question)}, detail: {question in
                QuestionDetailView(store: self.store,
                    question: question)})
        }
    }
}


