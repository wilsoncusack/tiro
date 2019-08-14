//
//  ActivitiesHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ActivitiesHorizontalList : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal: Bool
    @Binding var modalKind: String
    @Binding var selectedActivity: Activity?
    
    func activityCardBuilder(activity : Activity) -> ActivityCard {
        var participants : [Learner] = []
        if(activity.participants != nil) {
            participants = activity.participants!.allObjects as! [Learner]
        }
        return ActivityCard(title : activity.title, activity_date: activity.activity_date, image: activity.image, participants: participants)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Activities")
                    .font(.system(size: 22))
                    .bold()
                    .padding(.leading, 15)
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(mainEnv.activityStore.activities){ activity in
                        self.activityCardBuilder(activity: activity)
                            .onTapGesture{
                                self.selectedActivity = activity
                                self.showModal = true
                                self.modalKind = "activity"
                            }
                    }
                }.frame(height:230).padding(.leading, 15).padding(.trailing, 15)
            }.padding(.bottom,20)
        }
    }
}

#if DEBUG
struct ActivitiesHorizontalList_Previews : PreviewProvider {
    @State static var showModal = false
    @State static var modalKind = ""
    @State static var activity : Activity? = nil
    static var previews: some View {
        ActivitiesHorizontalList(showModal: $showModal, modalKind: $modalKind, selectedActivity: $activity).environmentObject(MainEnvObj())
    }
}
#endif
