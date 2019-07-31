//
//  ActivityBindable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/24/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class ActivityBindable : ObservableObject {
    
    @Published var title : String
    @Published var notes : String
    @Published var activityDate: Date
    @Published var image : Data?
    @Published var participants : [Learner]
    @Published var tags : [Tag]
    
//    var participantSet : Set<Learner> {
//        willSet{
//           willChange.send()
//       }
//    }
//
//    var participantSelectionManger: MySelectionManager {
//        willSet{
//                   willChange.send()
//               }
//    }
    
    init(title: String, notes : String?, activityDate : Date, image : Data?, participants: [Learner]){
        self.title = title
        self.notes = notes ?? ""
        self.activityDate = activityDate
        self.image = image
        self.participants = participants
//        self.participantSet = Set(participants)
//        self.participantSelectionManger = MySelectionManager(selected: participantSet)
    }
    
}





