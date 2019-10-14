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

    
    init(title: String, notes : String?, activityDate : Date, image : Data?, participants: [Learner], tags: [Tag]){
        self.title = title
        self.notes = notes ?? ""
        self.activityDate = activityDate
        self.image = image
        self.participants = participants
        self.tags = tags
    }
    
}





