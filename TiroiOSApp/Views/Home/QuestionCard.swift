//
//  QuestionCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/29/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TestModal: View {
    var body: some View {
        Text("hey")
    }
}

struct QuestionCard: View {
    var question: String
    var answer: String?
    var learner: Learner
    //@State var showModal = false
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text(question)
                    .frame(height: 45)
                    .lineLimit(2)

            }.padding(.bottom, 15)
            HStack{
                Text(learner.name)
                    .bold()
                Spacer()
                    Text("Answered")
                        //b.bold()
                        .foregroundColor(answer != nil ? .green : .orange)

            }
        }.frame(width: 235, height: 80)
//            .onTapGesture {
//                self.showModal = true
//        }
        .padding()
        
            .background(Color.white)
            .cornerRadius(8)
//        .shadow(radius: 5)
//            .sheet(isPresented: $showModal) {
//                TestModal()
//        }
    }
}

#if DEBUG
struct QuestionCard_Previews: PreviewProvider {
    static var mainEnv = MainEnvObj()
    static var previews: some View {
        QuestionCard(question: "Why don't cockroaches like cucumbers?", answer: nil, learner: mainEnv.learnerStore.learners[0] )
    }
}
#endif
