//
//  EmailCheck.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct EmailCheck : View {
    @State var emailAddress = ""
    @State var waitlistChoice = 0
    
    var waitlistDescription : some View {
        switch self.waitlistChoice{
        case 0:
            return Text("So early")
        case 1:
            return Text("So early")
        case 2:
            return Text("So early")
        case 3:
            return Text("So early")
        default :
            return Text("Some error")
        }
        
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Hi 👋")
                .font(.largeTitle)
                .bold()
            Spacer()
            Text("Thanks for downloading our app!")
                .lineLimit(nil)
            Spacer()
            Text("We are currently in a closed testing period. Please sign up on our website to join the waitlist: trytiro.com")
                .lineLimit(nil)
            Spacer()
            SegmentedControl(selection: $waitlistChoice) {
                Text("V0.1").tag(0)
                Text("Alpha").tag(1)
                Text("Beta").tag(2)
                Text("Public").tag(3)
            }
            
            
            
            
            
            Text("If you're on the waitlist and received")
                .lineLimit(nil)
            Spacer()
            TextField("email", text: $emailAddress)
                .textFieldStyle(.roundedBorder)
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: 500)
    }
}

#if DEBUG
struct EmailCheck_Previews : PreviewProvider {
    static var previews: some View {
        EmailCheck()
    }
}
#endif
