//
//  ActivityCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ActivityCard : View {
    //var activity : Activity
   // var image : Image? {log.presentable.mainImage()}
    var activity : Activity
    var participants : [Learner] {
        activity.participants!.allObjects as! [Learner]
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EE, MMM d")
        return formatter
    }()
    
    var learnerTrailingOffset : Length = 0
    @State var showModal = false
    
    
    var body: some View {
    
        ZStack(alignment: .bottom){
            
            if(activity.image_name != nil){
               Image(activity.image_name!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 210, height: 215)
            } else {
                Rectangle()
                    .frame(width: 210, height: 215)
                    .foregroundColor(.white)
            }
            Rectangle()
                .frame(width: 210, height: 90)
                //.opacity(0.9)
                .foregroundColor(.white)
                .overlay(
                    ZStack(alignment: .bottomTrailing){
                        ForEach(0 ..< participants.count){
                            ProfileImage(imageName: self.participants[$0].profile_image_name!, size: 30)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.trailing, Length(22 * $0))
                                .zIndex(Double(self.participants.count - $0))
                        }
                    }
                        //.frame(width: 200)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                    
                    , alignment: .bottomTrailing)
                .overlay(
                    Text(activity.title)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        //.frame(width: 195)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                        .padding(.leading, 15)
                    , alignment: .topLeading)
                .overlay(
                    Text( Self.dateFormatter.string(from: activity.activity_date))
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(.leading, 15)
                        .padding(.bottom, 10)
                    , alignment: .bottomLeading)
                //.tapAction({self.showModal.toggle()})
            
            
        }
        .cornerRadius(4)
        .shadow(radius: 5)
        //.present(Modal(ActivityDetailView(activity: activity, showModal: $showModal)))
        
        
    }
}

#if DEBUG
struct ActivityCard_Previews : PreviewProvider {
    static var data = DemoData()
    static var previews: some View {
        ActivityCard(activity: data.activityStore.activities[0])
       // Home().environmentObject(MainEnvObj())
    }
}
#endif
