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
        if participants.count == 0 {
            return ""
        }
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
                ZStack(alignment: .bottomTrailing){
                    if(activity.image_name != nil){
                        Image(activity.image_name!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .aspectRatio(contentMode: .fill)
                    } else if (activity.image != nil) {
                        DisplayUIImage(uiImageData : activity.image!)
                            .aspectRatio(contentMode: .fit)
                        
                    } else {
                        Image("headerPhoto")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: 100)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                }
                VStack(alignment: .leading){
                    HStack{
                        if(activity.title != nil ){
                                       
                    Text(activity.title!)
                        .font(.title)
                        .bold()
                        .lineLimit(nil)
                        Spacer()
                            
                        }
                    
                        NavigationLink(destination: ActivityCreateDetailView(showModal : $showModal, activity: activity, done : {})){
                                                           Text("Edit")
                                                               .foregroundColor(.white)
                                                               .padding(.leading, 10)
                                                               .padding(.trailing, 10)
                                                               .padding(.top, 5)
                                                               .padding(.bottom, 5)
                                                               .background(Color.blue)
                                                               .cornerRadius(20)
                                                               .padding(.leading, 10)
                                                               .padding(.top, 10)
                                                       }
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text( Self.dateFormatter.string(from: activity.activity_date))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(participantString)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }.padding(.top, 2)
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
                if(activity.notes != nil) {
                    Text(activity.notes!)
                        .lineLimit(nil)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.bottom, 20)
                }
            }
        }.edgesIgnoringSafeArea(.top)
            .navigationBarItems( trailing:
                Button(action : {self.showModal.toggle()}){
                                               Image(systemName: "xmark.circle.fill")
                                                   .resizable()
                                                   .frame(width: 30, height: 30)
                                                   .opacity(0.8)
                                                   .padding(.trailing, 10)
                                                   .padding(.top, 10)
                                                   .foregroundColor(.black)
                                                   .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
                                                   .shadow(radius: 5)
                                           }
        )
        
    }
    
}

#if DEBUG
struct ActivityDetailView_Previews : PreviewProvider {
    static var data = DemoData()
    @State static var showModal = true
    static var previews: some View {
        ActivityDetailView(activity: data.activityStore.activities[1], showModal: $showModal)//.environmentObject(MainEnvObj())
    }
}
#endif
