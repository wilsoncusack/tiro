//
//  TabbedMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TabbedMain : View {
    @State private var selection = 2
    @EnvironmentObject var mainEnvObj : MainEnvObj
    
    var body: some View {
        TabbedView(selection: $selection){
            Home().environmentObject(mainEnvObj)
                .tabItem({
                    selection == 1 ?
                        Image(systemName: "house.fill")
                            .imageScale(.large) :
                        Image(systemName: "house")
                            .imageScale(.large)
                    Text("Home")
                })
                .tag(1)
            CreateMain().environmentObject(mainEnvObj)
                .tabItem({
                    selection == 2 ?
                        Image(systemName: "plus.square.fill")
                            .imageScale(.large) :
                        Image(systemName: "plus.square")
                            .imageScale(.large)
                    Text("New")
                })
                .tag(2)
            Text("hey")
                .tabItem({
                    selection == 3 ?
                        Image(systemName: "questionmark.diamond.fill")
                            .imageScale(.large) :
                        Image(systemName: "questionmark.diamond")
                            .imageScale(.large)
                    Text("Feedback")
                })
                .tag(3)
        }
    }
}

#if DEBUG
struct TabbedMain_Previews : PreviewProvider {
    static var previews: some View {
        TabbedMain().environmentObject(MainEnvObj())
    }
}
#endif
