//
//  Landing.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


struct Landing : View {
    @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        NavigationView{
            VStack(alignment : .leading){
                Text("Hi 👋 Welcome to Tiro!")
                    .font(.title)
                    //.bold()
                    .padding(.bottom, 100)
                Text("Let's get your account setup")
                    .bold()
                    .font(.largeTitle)
                    .lineLimit(nil)
                Spacer()
                NavigationLink(destination: QuickNote(store: store)){
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.95)
                        .background(Color.blue)
                        .cornerRadius(8)
//                        .shadow(radius: 2)
                    
                }.padding(.bottom, 15)
            }.frame(width: UIScreen.main.bounds.width * 0.95)
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

#if DEBUG
//struct Landing_Previews : PreviewProvider {
//    static var previews: some View {
//        Landing(createUser: {}).environmentObject(MainEnvObj())
//    }
//}
#endif
