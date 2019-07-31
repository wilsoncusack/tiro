//
//  QuestionCreateDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuestionCreateDetailView : View {
//    @EnvironmentObject var mainEnv: MainEnvObj
//    @ObservedObject var question : Question
//    @Binding var showModal : Bool
    @State var myText = ""
    
    
    var body: some View {
        Form{
            TextField("Question but what if it's really long and we want to see if it'll wrapp", text: $myText)
                .lineLimit(nil)
                .frame(width: 500, height: 200)
            
            //Picker(
//            Picker("Test", selection: $question.asker){
//                ForEach(mainEnv.learnerStore.learners){learner in
//                    Text(learner.name)
//                }
//            }
//            Button(action: {self.showModal = false}){
//                Text("close modal")
//            }
            //TextField("Answer", text: $question.answer_text)
        }
    }
}

#if DEBUG
//struct QuestionCreateDetailView_Previews : PreviewProvider {
//    static var previews: some View {
//        QuestionCreateDetailView()
//    }
//}
#endif
