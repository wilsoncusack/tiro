//
//  ActivityHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ActivityHorizontalList: View {
    @ObservedObject var store: Store<ActivityState, ActivityAction>
    var activities: [Activity]
    var body: some View {
        VStack{
        HStack{
            SectionTitle("Activities")
            Spacer()
            NavigationLink(destination: ActivityList(store: store, activities: activities)){
                Text("See All")
            }.padding(.trailing, 15)
        }
            HorizontalScrollList(items: activities, card: {activity in ActivityCard(activity: activity)}, detail: {activity in ActivityDetailView(store: self.store, activity: activity)})
    }
    }
}


