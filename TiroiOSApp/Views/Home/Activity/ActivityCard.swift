//
//  ActivityCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


struct LearnersPhotoOverlay: View {
    @ObservedObject var activity: Activity
    var participants: [(Learner, Int)] {
        var iterations = -1
        let learners = activity.participants!.allObjects as! [Learner]
        return learners.map {learner -> (Learner, Int) in
            iterations += 1
            return (learner, iterations)
        }
        
    }
    var body: some View {
        ZStack{
            ForEach(participants, id: \.0.id){(learner, iteration) in
                ProfileImage(learner: learner, size: 30)
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .padding(.trailing, CGFloat(22 * iteration))
                    .zIndex(Double(self.activity.participants!.count - iteration))
            }
        }
    }
}

struct ActivityCard : View {
    @ObservedObject var activity: Activity
    
    var participants: [(Learner, Int)] {
        var iterations = -1
        let learners = activity.participants!.allObjects as! [Learner]
        return learners.map {learner -> (Learner, Int) in
            iterations += 1
            return (learner, iterations)
        }
        
    }
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EE, MMM d")
        return formatter
    }()
    
    @State var learnerTrailingOffset : CGFloat = 0
    
    var hasImage: Bool {
        activity.image != nil
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            if(hasImage){
                DisplayUIImage(uiImageData: activity.image!)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 210, height: 215)
                
            } else {
                Rectangle()
                    .frame(width: 210, height: 215)
                    .foregroundColor(.clear)
            }
            Rectangle()
                .frame(width: 210, height: 90)
                .opacity(0.95)
                .foregroundColor(.clear)
                .overlay(
                        LearnersPhotoOverlay(activity: activity)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                    
                    , alignment: .bottomTrailing)
                .overlay(
                    Text(activity.title)
                        .font(.subheadline)
                        .foregroundColor(hasImage ? .white : .black)
                        .fontWeight(.semibold)
                        //.frame(width: 195)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                        .padding(.leading, 15)
                    .shadow(radius: hasImage ? 4 : 0)
                    , alignment: .topLeading)
                .overlay(
                    Text( Self.dateFormatter.string(from: activity.activity_date))
                        .foregroundColor(hasImage ? .white : .black)
                        .font(.caption)
                        .padding(.leading, 15)
                        .padding(.bottom, 10)
                        .shadow(radius: hasImage ? 4 : 0)
                    , alignment: .bottomLeading)
            
            
            
        }
        .cornerRadius(4)
        .overlay(RoundedRectangle(cornerRadius: 4)
        .stroke(Color.gray, lineWidth: 0.3))
    }
}

#if DEBUG
//struct ActivityCard_Previews : PreviewProvider {
//    static var data = DemoData()
//    static var previews: some View {
//        ActivityCard(title: "test", activity_date: Date(), participants: [])
//       // Home().environmentObject(MainEnvObj())
//    }
//}
#endif
