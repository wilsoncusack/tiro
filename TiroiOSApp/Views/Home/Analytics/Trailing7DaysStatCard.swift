//
//  trailing7DaysStatCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct Trailing7DaysStatCard: View {
    var activities: [Activity]
    var tagAnalyticsData: [AnalyticsCardData] {
        attributeCountTouples(elements: activities, getAttributes: {activity in activity.tags?.allObjects as! [Tag]}, getString: {tag in tag.name})
    }
    
     var body: some View {
           VStack(alignment: .leading){
               Text("\(activities.count) \(activities.count == 1 ? "Activity" : "Activities") in the last 7 days").foregroundColor(.secondary).padding(.leading, 15).padding(.top, 10)
               PercentageBar(tagAnalyticsData: tagAnalyticsData).padding(.leading, 15)
           }
           
       }
}


