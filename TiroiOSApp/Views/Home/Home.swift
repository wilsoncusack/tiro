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
    @Binding var showModal : Bool

    
    var body : some View {
        NavigationView{
        if(modalKind == "activity"){
           if(self.activity != nil){
            ActivityDetailView(activity: activity!, showModal: $showModal)//.environmentObject(self.mainEnv)
           }
       } else if (self.modalKind == "activityCreate") {
            ActivityCreateDetailView(showModal: $showModal, activity: activity).environmentObject(mainEnv)
       }
        }
    }
}


struct Home : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @State var selectedActivity : Activity? = nil
    @State var showModal = false
    @State var modalKind = ""
    var activities : [Activity] {
        mainEnv.activityStore.activities
    }
    
    
    func activityCardBuilder(activity : Activity) -> ActivityCard{
        var participants : [Learner] = []
        if(activity.participants != nil) {
                participants = activity.participants!.allObjects as! [Learner]
        }
        return ActivityCard(title : activity.title, activity_date: activity.activity_date, image: activity.image, participants: participants)
    }
    
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                Divider().padding(.leading, 15)
                //Text(mainEnv.activityStore.activities[0].title)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Activities")
                            .font(.system(size: 22))
                            .bold()
                            .padding(.leading, 15)
                        Spacer()
                        Button(action: {
                            self.showModal = true
                            self.selectedActivity = nil
                            self.modalKind = "activityCreate"

                        }){
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                                .foregroundColor(.black)
                                .padding(.trailing, 15)
                        }
                        
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10){
                            ForEach(activities){ activity in
                                self.activityCardBuilder(activity: activity)
                                    .tapAction({
                                    self.selectedActivity = activity
                                    self.showModal = true
                                    self.modalKind = "activity"
                                })
                            }
                        }.frame(height:230).padding(.leading, 15)
                    }.padding(.bottom,20)
                }
                
                Button(action: {
                    self.mainEnv.deleteUser()
                    
                    for learner in  self.mainEnv.learnerStore.learners{
                        self.mainEnv.deleteLearner(learner: learner)
                    }
                    for activity in self.mainEnv.activityStore.activities{
                        self.mainEnv.deleteActivity(activity: activity)
                    }}){
                        Text("Reset")
                }
                
                
            }
            .sheet(isPresented: $showModal, content: {
                PopoverContainer(modalKind: self.$modalKind, activity: self.$selectedActivity, showModal: self.$showModal).environmentObject(self.mainEnv)
            })
                
                .navigationBarTitle("Home")
            
        }
        
    }
    
}

func setup(){
    
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var data = DemoData()
    //_ = print("hey")
    static var previews: some View {
        Home().environmentObject(MainEnvObj())
    }
}
#endif
