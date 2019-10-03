//
//  ActivityCard.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//struct LearnerImageOverlay: View {
//
//    var body: some View {
//
//    }
//}

struct ActivityCard : View {
   // @EnvironmentObject var mainEnv: MainEnvObj
    //var activity : Activity
   // var image : Image? {log.presentable.mainImage()}
//    var title : String?
//    var activity_date : Date
//    var image : Data?
//    var participants : [Learner]
    @ObservedObject var activity: Activity
    //@State var iteration : Int = 0
    
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
    
//
//    func builder(_ learner: Learner) -> some View {
//
//        var save =
//            ProfileImage(learner: learner, size: 30)
//                .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                .padding(.trailing, CGFloat(22 * iteration))
//                .zIndex(Double(self.activity.participants!.count - iteration))
//       // iteration += 1
//        return save
//
//
//
//    }
    
    var body: some View {
    
        ZStack(alignment: .bottom){
            
            if(activity.image != nil){
                DisplayUIImage(uiImageData: activity.image!)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 210, height: 215)

            } else {
                Rectangle()
                    .frame(width: 210, height: 215)
                    .foregroundColor(.white)
            }
            Rectangle()
                .frame(width: 210, height: 90)
                .opacity(0.95)
                .foregroundColor(.white)
                //.blendMode(.overlay)
                .overlay(
                    ZStack(alignment: .bottomTrailing){
//                        ForEach(0 ..< participants.count){
//                            ProfileImage(learner: self.participants[$0], size: 30)
//                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                            .padding(.trailing, CGFloat(22 * $0))
//                            .zIndex(Double(self.activity.participants!.count - $0))
//                        }
                        ForEach(participants, id: \.0.id){(learner, iteration) in
                            ProfileImage(learner: learner, size: 30)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.trailing, CGFloat(22 * iteration))
                                .zIndex(Double(self.activity.participants!.count - iteration))
                        }
//                        ForEach(participants){learner in
//                            self.builder(learner)
//                        }
                    }
                        //.frame(width: 200)
                        .padding(.trailing, 15)
                        .padding(.bottom, 10)
                    
                    , alignment: .bottomTrailing)
                .overlay(
                    Text(activity.title ?? "")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        //.frame(width: 195)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                        .padding(.leading, 15)
                    , alignment: .topLeading)
                .overlay(
                    Text( Self.dateFormatter.string(from: activity.activity_date))
                       // .foregroundColor(.white)
                         .foregroundColor(.black)
                        .font(.caption)
                        .bold()
                        //.shadow(radius: 5)
                        .padding(.leading, 15)
                        .padding(.bottom, 10)
                    , alignment: .bottomLeading)
                
            
            
        }
        .cornerRadius(4)
//        .shadow(radius: 5)
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
