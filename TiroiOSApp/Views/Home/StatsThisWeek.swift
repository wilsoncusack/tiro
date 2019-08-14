//
//  StatsThisWeek.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/30/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

class Test : ObservableObject {
    @FetchRequest(fetchRequest: Activity.fetchRequest())
    var fetchedResults: FetchedResults
}

// fix this, imrpove this, at some point

struct StatsThisWeek: View {
    @EnvironmentObject var mainEnv : MainEnvObj
    var statsBarWidth = UIScreen.main.bounds.width - 65
    var aStore = ActivityStore()
    func getColor(tag : Tag) -> Color {
        switch tag.name {
        case "writing":
            return .red
        case "science":
            return .blue
        case "math":
            return .green
        case "reading":
        return .yellow
            
        default:
            return .orange
        }
    }
    
    func buildRect(tagCount: ActivityStore.TagCount) -> some View {
        return Rectangle()
            .foregroundColor(getColor(tag: tagCount.tag))
            .frame(width: ((statsBarWidth/CGFloat( tags.count)) * CGFloat(tagCount.percentage)), height: 40)
        .fixedSize()
        .cornerRadius(6)
    }
    
    
    var tags : [ActivityStore.TagCount]{
      //  mainEnv.activityStore.tags
        //mainEnv.tagCounts
        mainEnv.activityStore.mostCommonTagsLastSevenDays
    }
//
    var body: some View {

        
        ZStack(alignment: .topLeading){
            Rectangle()
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 20, height: 130)
                .cornerRadius(8)
            VStack(alignment: .leading){
                // will need 
                Text("\(tags.count) activites in the last 7 days")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                HStack{
                    ForEach( tags, id: \.self){tagCount in
                            self.buildRect(tagCount: tagCount)
                    }
                }
                
                HStack{
                    ForEach( tags, id: \.self){tagCount in
                        Text("\(tagCount.count) \(tagCount.tag.name) ")
                            .foregroundColor(self.getColor(tag: tagCount.tag))
                    }
                }
            
            
            }.padding()
            }.frame(height: 130).padding(.leading, 10).padding(.bottom, 15)
        
    }
}

#if DEBUG
struct StatsThisWeek_Previews: PreviewProvider {
    static var previews: some View {
        StatsThisWeek()
    }
}
#endif
