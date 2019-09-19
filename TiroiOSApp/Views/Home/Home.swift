//
//  Home.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

struct PopoverContainer : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var modalKind : String
    @Binding var activity : Activity?
    @Binding var question : Question?
    @Binding var showModal : Bool
    var q : Question {
       Question(question_text: "", answer_text: nil, asker: mainEnv.learnerStore.learners[0], created_by: mainEnv.userStore.user!)
    }
    
    var body : some View {
        NavigationView{
        if(modalKind == "activity"){
           if(self.activity != nil){
            ActivityDetailView(activity: activity!, showModal: $showModal)//.environmentObject(self.mainEnv)
           }
        } else if(self.modalKind == "question"){
            QuestionDetailView(question: question!, showModal: $showModal)
        }else if (self.modalKind == "activityCreate") {
            ActivityCreateDetailView(showModal: $showModal, activity: activity, done: {}).environmentObject(mainEnv)
        } else if (self.modalKind == "questionCreate"){
            //QuestionCreateDetailView(showModal $showModal, question: question, done: {}).environmentObject(mainEnv)
        } else if (self.modalKind == "learnerCreate"){
            LearnerCreateModal(showModal: $showModal).environmentObject(mainEnv)
        }
            
        }
    }
}


struct Home : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @State var selectedActivity : Activity? = nil
    @State var selectedQuestion : Question? = nil
    @State var showModal = false
    @State var modalKind = ""

    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false){
                
                VStack(alignment:.leading){
                //Divider().padding(.leading, 15)
                
                Text("Summary")
                    .font(.system(size: 22))
                    .bold()
                    .padding(.leading, 15)
                    .padding(.top, 15)
                StatsThisWeek()
                
                //Text(mainEnv.activityStore.activities[0].title)
                ActivitiesHorizontalList(showModal: $showModal, modalKind: $modalKind, selectedActivity: $selectedActivity)
                  
                    
                QuestionHorizontalList(showModal: $showModal, modalKind: $modalKind, question: $selectedQuestion)
                
                HStack {
                    Text("Learners")
                        .font(.system(size: 22))
                        .bold()
                        .padding(.leading, 15)
                    Spacer()
                    Button(action: {
                        self.modalKind = "learnerCreate"
                        self.showModal = true
                        
                    }){
                        Image(systemName: "plus.circle")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding(.trailing, 15)
                    }
                    
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom, spacing: 10){
                        ForEach(mainEnv.learnerStore.learners){learner in
                            VStack{
                            ProfileImage(imageName: learner.profile_image_name!, size: 100)
                            Text(learner.name)
                            }
                        }
                    }.padding(.leading, 15)
                    
                }
                //QuestionCard(question: "Why don't cockroaches like cucumbers?", answer: nil, learner: mainEnv.learnerStore.learners[0] )
                    
                
//                Button(action: {
//
//
//                    for tag in self.mainEnv.tagStore.tags{
//                       self.mainEnv.tagStore.delete(tag: tag)
//                   }
//                   for tagType in self.mainEnv.tagTypeStore.tagTypes{
//                       self.mainEnv.tagTypeStore.delete(tagType: tagType)
//                   }
//                    for learner in  self.mainEnv.learnerStore.learners{
//                        self.mainEnv.deleteLearner(learner: learner)
//                    }
//                    for activity in self.mainEnv.activityStore.activities{
//                        self.mainEnv.deleteActivity(activity: activity)
//                    }
//                    for question in self.mainEnv.questionStore.questions{
//                        self.mainEnv.questionStore.delete(question: question)
//                    }
//
//
//                     self.mainEnv.deleteUser()
//
//
//                }){
//                        Text("Reset")
//                }
                
           
                }
                 
               
            }//.edgesIgnoringSafeArea(.top)
            .background(Color.init(red: 0.92, green: 0.92, blue: 0.95))
                

            .sheet(isPresented: $showModal, content: {
                PopoverContainer(modalKind: self.$modalKind, activity: self.$selectedActivity, question: self.$selectedQuestion, showModal: self.$showModal).environmentObject(self.mainEnv)
            })
                .navigationBarTitle("Home")
           .navigationBarHidden(true)
            
        }
    }
    
}

func setup(){
    
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var data = DemoData()
    static var previews: some View {
        Home().environmentObject(MainEnvObj())
    }
}
#endif
