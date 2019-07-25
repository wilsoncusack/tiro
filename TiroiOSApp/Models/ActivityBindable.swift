//
//  ActivityBindable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/24/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class ActivityBindable : BindableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    var title : String {
        willSet{
            willChange.send()
        }
    }
    var notes : String {
        willSet{
            willChange.send()
        }
    }
    var activityDate: Date {
        willSet{
            willChange.send()
        }
    }
    var image : Data? {
        willSet{
            willChange.send()
        }
    }
    var participants : [Learner] {
        willSet{
            willChange.send()
        }
    }
    
    init(title: String, notes : String?, activityDate : Date, image : Data?, participants: [Learner]){
        self.title = title
        self.notes = notes ?? ""
        self.activityDate = activityDate
        self.image = image
        self.participants = participants
    }
    
}





