//
//  QuickNote.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct QuickNote : View {
     @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        VStack(alignment : .leading){
            Text("Quick Note")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 15)
            Text("We care a lot about your privacy. For now, everything you enter in this app, except feedback, is stored locally on your device only, not on our servers. The only information we keep is anonymous usage.")
                //.font(.title)
                .lineLimit(nil)
                .padding(.bottom, 15)
           Spacer()
            NavigationLink(destination: UserDetails(store: store)){
                Text("Next")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.95)
                    .background(Color.blue)
                    .cornerRadius(8)
            }.padding(.bottom, 15)
        }.frame(width: UIScreen.main.bounds.width * 0.95)
        .navigationBarHidden(true)
    }
}

#if DEBUG
//struct QuickNote_Previews : PreviewProvider {
//    static var previews: some View {
//        QuickNote(createUser: {}).environmentObject(MainEnvObj())
//    }
//}
#endif
