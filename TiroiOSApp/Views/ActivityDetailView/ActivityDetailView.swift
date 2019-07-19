//
//  ActivityDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ActivityDetailView : View {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return formatter
    }()
    
    var participants : [Learner] {
        activity.participants!.allObjects as! [Learner]
    }
    
    var participantString : String {
        var str = "with "
        for index in 0...(participants.count - 1){
            if(participants.count == 1 || self.participants.count - 1 == index){
                str = str + participants[index].name
            } else if(self.participants.count == 2){
                str = str + participants[index].name +  " and "
            } else if (self.participants.count > 2){
                if(self.participants.count - 2 == index){
                    str = str  + participants[index].name + ", and "
                } else {
                    str = str  + participants[index].name + ", "
                }
            }
           
        }
         return str
    }
    
    var activity : Activity
    @Binding var showModal : Bool
    
    var body: some View {
        ScrollView(.vertical){
        VStack(alignment: .leading){
            Image(activity.image_name!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Button(action : {self.showModal.toggle()}){
                    Image(systemName: "xmark.circle.fill")
                        //.foregroundColor(Color.init(red: 1, green: 1, blue: 1))
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                        .foregroundColor(.black)
                        .opacity(0.8)
                    }
                    , alignment: .topTrailing)
                .overlay(
                    Button(action : {}){
                        Text("Edit")
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.leading, 10)
                            .padding(.top, 10)
                            //.foregroundColor(.black)
                            .opacity(0.8)
                    }
                    , alignment: .topLeading)
            VStack(alignment: .leading){
                
                
                Text(activity.title)
                    .font(.title)
                    .bold()
                    .lineLimit(nil)
                //Spacer()
                
                HStack(alignment: .firstTextBaseline) {
                    Text( Self.dateFormatter.string(from: activity.activity_date))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                
                Spacer()
                
                Text(participantString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }.padding(.top, 2)
           }.padding(.leading, 15).padding(.trailing, 15)
            
            
                if(activity.notes != nil) {
                  
                    Text(activity.notes!)
                        .lineLimit(nil)
                        .padding(.leading, 15)
                         .padding(.trailing, 15)
                    .padding(.bottom, 20)
                
                
            }
            }
            
            
        }.edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct ActivityDetailView_Previews : PreviewProvider {
    static var data = DemoData()
    @State static var showModal = true
    static var previews: some View {
        ActivityDetailView(activity: data.activityStore.activities[1], showModal: $showModal)
    }
}
#endif
