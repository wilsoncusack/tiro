//
//  Home.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData


struct LearnerCard: View {
    @ObservedObject var learner: Learner
    var body: some View {
        VStack{
            ProfileImage(learner: learner, size: 100)
            Text(learner.name)
        }
    }
}

struct SectionTitle: View {
    var title: String
    
    init(_ title: String){
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 22))
            .bold()
            .padding(.leading, 15)
    }
}


struct HomeReusable: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var learner: Learner?
    var tag: Tag?
    var activities: [Activity]
    var questions: [Question]
    var learners: [Learner]
    var tags: [Tag]
    
    @FetchRequest(entity: TagType.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TagType.name, ascending: false)])
    var tagTypes: FetchedResults<TagType>
    
    
    var learnerIsNil: Bool {
        learner == nil
    }
    
    @State var showModal = false
    @State var showTagModal = false
    
    func getNavTitle() -> String {
        if (tag != nil && learner != nil){
            return "\(learner!.name), \(tag!.name)"
        }
        if self.tag != nil {
            return "Tag: \(tag!.name)"
        }
        if self.learner != nil {
            return "\(learner!.name)"
        }
        return "Home"
    }
    
    var body: some View {
        
        ScrollView{
            VStack{
                VStack{
                    //SectionTitle("Summary")
                    Trailing7DaysStatCard(activities: activities)
                        .padding(.bottom, 40)
                    
                    
                    ActivityHorizontalList(
                        store: self.store.view(
                            value: {$0.activityState},
                            action: {.activity($0)}),
                        activities: activities).padding(.bottom, 40)

                    QuestionHorizontalList(store:
                        self.store.view(value: {$0.questionState}, action: {.question($0)}),
                        questions: questions)
                        .padding(.bottom, 40)
                    
                    if(learnerIsNil){
                        LearnerHorizontalList(store: store, tag: tag, activities: activities, questions: questions, learners: learners, tags: tags, showModal: $showModal)
                            .padding(.bottom, 40)
                    }
                    
                    if(tag == nil){
                        TagHorizontalList(store: store, learner: learner, activities: activities, questions: questions, learners: learners, tags: tags, showTagModal: $showTagModal)
                            .sheet(isPresented: $showTagModal){
                                TagCreate(
                                    store: self.store.view(
                                        value: {$0.tagState},
                                        action: {.tag($0)}),
                                    showModal: self.$showTagModal,
                                    tagTypes: self.tagTypes.map {$0})
                        }.padding(.bottom, 40)
                    }
                    
                }
            }
        }
        .sheet(isPresented: self.$showModal, content: {
            LearnerCreateModal(
                store: self.store.view(
                value: {$0.learnerState},
                action: {.learner($0)}
            ),
                               showModal: self.$showModal)
        })
            // sheet probably isn't working currently
            .navigationBarTitle(Text(getNavTitle()), displayMode: .large)
            //.navigationBarHidden(learnerIsNil)
            .navigationBarItems(trailing:
                Group{
                    if(learnerIsNil){
                        EmptyView()
                    } else {
                        NavigationLink(destination: LearnerDetail(
                            store: self.store.view(
                                value: {$0.learnerState},
                                action: {.learner($0)}
                            ),
                            name: learner!.name,
                            image: learner!.image,
                            learner: learner!)){
                            ProfileImage(learner: learner!, size: 30)
                        }.buttonStyle(PlainButtonStyle())
                    }
            })
    }
    
}



//struct Home: View {
//    @ObservedObject var store: Store<AppState, AppAction>
//    
//    init(store: Store<AppState, AppAction>){
//        self.store = store
//        askNotification()
//    }
//    
//    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
//    var learners: FetchedResults<Learner>
//    
//    
//    @FetchRequest(entity: Activity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Activity.activity_date, ascending: false)])
//    var activities: FetchedResults<Activity>
//    
//    @FetchRequest(entity: Question.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Question.date_created, ascending: false)])
//    var questions: FetchedResults<Question>
//    
//    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.first_name, ascending: false)])
//    var users: FetchedResults<User>
//    
//    @FetchRequest(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: false)])
//    var tags: FetchedResults<Tag>
//    
//    
//    
//    func reset(){
//        for thing in activities {
//            AppDelegate.shared.persistentContainer.viewContext.delete(thing)
//        }
//        for thing in questions {
//            AppDelegate.shared.persistentContainer.viewContext.delete(thing)
//        }
//        for thing in learners {
//            AppDelegate.shared.persistentContainer.viewContext.delete(thing)
//        }
//        for thing in users {
//            AppDelegate.shared.persistentContainer.viewContext.delete(thing)
//        }
//        AppDelegate.shared.saveContext()
//    }
//    
//    var body: some View{
//        NavigationView{
////            Button(action: {self.reset()}){
////                Text("reset")
////            }
//            HomeReusable(store: store, learner: nil, activities: activities.map {$0}, questions: questions.map {$0}, learners: learners.map {$0}, tags: tags.map {$0})
//            
//        }
//  //  .navigationViewStyle(DoubleColumnNavigationViewStyle())
//    }
//}
