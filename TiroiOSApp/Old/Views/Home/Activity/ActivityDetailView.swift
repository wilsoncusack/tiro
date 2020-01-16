//
//  ActivityDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

let longDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
    return formatter
}()

func participantString(_ participants: [Learner]) -> String {
    if participants.count == 0 {
        return ""
    }
    var str = "Learners: "
    for index in 0...(participants.count - 1){
        if(participants.count == 1 || participants.count - 1 == index){
            str = str + participants[index].name
        } else if(participants.count == 2){
            str = str + participants[index].name +  " and "
        } else if (participants.count > 2){
            if(participants.count - 2 == index){
                str = str  + participants[index].name + ", and "
            } else {
                str = str  + participants[index].name + ", "
            }
        }
        
    }
    return str
}

func tagString(_ tags: [Tag]) -> String {
    if tags.count == 0 {
        return ""
    }
    let stringsArray = tags.map {$0.name}
    return "Tags: " + stringsArray.joined(separator: ", ")
}

struct ActivityDetailView : View {
    @ObservedObject var store: Store<ActivityState, ActivityAction>
    @ObservedObject var activity : Activity
    @State var editActive = false
    
    var participants : [Learner] {
        activity.participants?.allObjects as! [Learner]
    }
    
    var tags: [Tag] {
      activity.tags?.allObjects as! [Tag]
    }
    
    
    
    
    
    var body: some View {
        
        ScrollView(.vertical){
            
            
            VStack(alignment: .leading){
                VStack{
                if (activity.image != nil) {
                    DisplayUIImage(uiImageData : activity.image!)
                        .aspectRatio(contentMode: .fill)
                }
                }.frame(width: UIScreen.main.bounds.width)
                VStack(alignment: .leading, spacing: 2) {
                    Text(longDateFormatter.string(from: activity.activity_date))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if(!participants.isEmpty){
                        Text(participantString(participants))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if(!tags.isEmpty){
                    Text(tagString(activity.tags?.allObjects as! [Tag]))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 5)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 15)
                
                if(activity.link != nil){
                    Link(activity.link!)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                        .padding(.bottom, 10)
                }
                
                if(activity.notes == nil){
                    Text("Notes...")
                        .italic()
                        .foregroundColor(.secondary)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                } else {
                    Text(activity.notes!)
                        .lineLimit(nil)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.bottom, 20)
                }
                
            }
        }
            
        .navigationBarTitle(Text(activity.title), displayMode: .inline)
            
        .navigationBarItems( trailing:
            
            NavigationLink(destination: ActivityCreateDetailView(store: store, activity: activity, done : {})){
                Text("Edit")
            }
            
            
        )
        
        
        
    }
    
}

