//
//  QuestionDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/31/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuestionDetailView: View {
    var question : Question
    @Binding var showModal : Bool
    
    var body: some View {
        VStack(alignment: .leading){
        ZStack(alignment: .topLeading){
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 350)
               // .foregroundColor(.blue)
               .foregroundColor(Color.init(red: 251/255, green: 251/255, blue: 253/255))
            VStack(alignment: .leading){
                Text("Question")
                    .font(.system(size: 34))
                    .fontWeight(.black)
                    .padding(.bottom, 15)
//                    .foregroundColor(.white)
                  //  .padding(.leading, 0)
                Text(question.question_text)
                    .font(.system(size: 22))
                    .lineLimit(nil)
//                    .foregroundColor(.white)
                Spacer()
                HStack{
                    ProfileImage(learner: question.asker, size: 50)
                    Text(question.asker.name)
                        .fontWeight(.bold)
//                        .foregroundColor(.white)
                }//.offset(y: -15)
            }.padding(.top, 15).padding(.leading, 15).padding(.trailing, 10).padding(.bottom, 15)
            
        }//.offset(y: -250)
            VStack(alignment: .leading){
                HStack(alignment: .center){
            Text("Answer")
                .font(.system(size: 34))
                .fontWeight(.black)
                
                    Spacer()
                    NavigationLink(destination: QuestionCreateDetailView(showModal: $showModal, question: question, done: {})){
                            Text("Edit")
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .padding(.leading, 10)
                                .padding(.top, 10)
                        }
                    
                
                    }.padding(.bottom, 15)
            Rectangle()
                //.aspectRatio(contentMode: .fill)
                .frame(minWidth: 0,  maxWidth: UIScreen.main.bounds.width, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .foregroundColor(.white)
                .overlay(
            Text(question.answer_text ?? "Not answered")
                .foregroundColor(question.answer_text != nil ? .primary : .secondary )
                    
                .lineLimit(nil), alignment: .topLeading)
                
                //.frame(width: UIScreen.main.bounds.width)
            }.padding(.leading, 15).padding(.trailing, 15)
            
        }.offset(y: -110)
        .navigationBarItems(trailing:
                Button(action : {self.showModal.toggle()}){
                                               Image(systemName: "xmark.circle.fill")
                                                
                                                   .resizable()
                                                   .frame(width: 30, height: 30)
                                                //.foregroundColor(.white)
                                                   .opacity(0.8)
                                                   .padding(.trailing, 10)
                                                   .padding(.top, 10)
                                                   .foregroundColor(.black)
                                                  
                                                   
                                           }
        )
    }
}

#if DEBUG
struct QuestionDetailView_Previews: PreviewProvider {
    static var mainEnv = MainEnvObj()
    
    @State static var showModal = true
    static var previews: some View {
        QuestionDetailView(question: MainEnvObj().questionStore.questions[0], showModal: $showModal)
    }
}
#endif
