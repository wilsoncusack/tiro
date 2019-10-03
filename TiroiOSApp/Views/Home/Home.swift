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
    @Binding var learner : Learner?
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
            } else if (self.modalKind == "learnerEdit"){
                LearnerDetail(showModal: $showModal, learner: learner!)
                
            }
        }
    }
}


struct LearnerCard: View {
    var learner: Learner
    var body: some View {
        VStack{
            ProfileImage(learner: learner, size: 100)
            Text(learner.name)
        }
    }
}

struct NewLearnerDetail: View {
    //@EnvironmentObject var mainEnv : MainEnvObj
    @ObservedObject var learner: Learner
    var body: some View {
        VStack{
            ProfileImage(learner: learner, size: 100)
            Text(learner.name)
        }
        .navigationBarTitle(learner.name)
    }
}

struct NewAcitivityDetail: View {
    @ObservedObject var activity: Activity
    @State var showModal = true
    
    var body: some View {
        ActivityDetailView(activity: activity, showModal: $showModal)
    }
}

//class Store: ObservableObject {
//    @Published var learner: Learner? = nil
//
//    var activitiesPredicate: NSPredicate {
//        NSPredicate(
//    }
//    var activities: FetchRequest<NSFetchRequestResult> {
//        FetchRequest<NSFetchRequestResult>(entity: Activity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Activity.activity_date, ascending: true)])
//    }
//}

struct Home2: View {
    var activityFilter: (Activity) -> Bool
    
   @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>

    
    @FetchRequest(entity: Activity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Activity.activity_date, ascending: true)])
    var activities: FetchedResults<Activity>

    
    var body: some View {
        NavigationView{
            VStack{
                HorizontalList(items: activities.filter {self.activityFilter($0)}, card: {activity in ActivityCard(activity: activity)}, detail: {activity in NewAcitivityDetail(activity: activity)})
                
                HorizontalList(items: learners.map {$0}, card: {learner in LearnerCard(learner: learner)}, detail: {learner in NewLearnerDetail(learner: learner)})
            }
            
        }
    }
}

struct Home: View {
    
    var body: some View {
        Home2(activityFilter: { activity -> Bool in
            return true
        })
    }
}


//struct Home : View {
//    @EnvironmentObject var mainEnv : MainEnvObj
//    @State var selectedActivity : Activity? = nil
//    @State var selectedQuestion : Question? = nil
//    @State var selectedLearner : Learner? = nil
//    @State var showModal = false
//    @State var modalKind = ""
//
//    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
//    var learners: FetchedResults<Learner>
//
//
//    var body: some View {
//        NavigationView {
//
//            ScrollView(showsIndicators: false){
//
//                VStack(alignment:.leading){
//                    //Divider().padding(.leading, 15)
//
//                    Text("Summary")
//                        .font(.system(size: 22))
//                        .bold()
//                        .padding(.leading, 15)
//                        .padding(.top, 15)
//                    StatsThisWeek()
//
//                    //Text(mainEnv.activityStore.activities[0].title)
//                    ActivitiesHorizontalList(showModal: $showModal, modalKind: $modalKind, selectedActivity: $selectedActivity)
//
//
//                    QuestionHorizontalList(showModal: $showModal, modalKind: $modalKind, question: $selectedQuestion)
//
////                    HorizontalList(items: learners, card: learnerCardTest, @ViewBuilder detail: {learner in
////                        NewLearnerDetail(learner: learner)
////                    })
//                    HorizontalList(items: learners, card: {learner in LearnerCard(learner: learner)}, detail: {learner in NewLearnerDetail(learner: learner)})
//
//
//
////                    LearnersHorizontalList(showModal: self.$showModal, selectedLearner: self.$selectedLearner, modalKind: self.$modalKind).padding(.bottom, 20)
//
//
//                    //QuestionCard(question: "Why don't cockroaches like cucumbers?", answer: nil, learner: mainEnv.learnerStore.learners[0] )
//
//
//                    //                Button(action: {
//                    //
//                    //
//                    //                    for tag in self.mainEnv.tagStore.tags{
//                    //                       self.mainEnv.tagStore.delete(tag: tag)
//                    //                   }
//                    //                   for tagType in self.mainEnv.tagTypeStore.tagTypes{
//                    //                       self.mainEnv.tagTypeStore.delete(tagType: tagType)
//                    //                   }
//                    //                    for learner in  self.mainEnv.learnerStore.learners{
//                    //                        self.mainEnv.deleteLearner(learner: learner)
//                    //                    }
//                    //                    for activity in self.mainEnv.activityStore.activities{
//                    //                        self.mainEnv.deleteActivity(activity: activity)
//                    //                    }
//                    //                    for question in self.mainEnv.questionStore.questions{
//                    //                        self.mainEnv.questionStore.delete(question: question)
//                    //                    }
//                    //
//                    //
//                    //                     self.mainEnv.deleteUser()
//                    //
//                    //
//                    //                }){
//                    //                        Text("Reset")
//                    //                }
//
//
//                }
//
//
//            }//.edgesIgnoringSafeArea(.top)
//                .background(Color.init(red: 0.92, green: 0.92, blue: 0.95))
//                //.offset(y: -50)
//                .padding(.top, -50)
//
//                .sheet(isPresented: $showModal, content: {
//                    PopoverContainer(modalKind: self.$modalKind, activity: self.$selectedActivity, question: self.$selectedQuestion, learner: self.$selectedLearner, showModal: self.$showModal).environmentObject(self.mainEnv)
//                })
//                .navigationBarTitle("Home")
//                .navigationBarHidden(true)
//
//        }
//    }
//
//}

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
