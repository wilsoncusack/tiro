//
//  TabbedMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TabbedMain : View {
    @State private var selection = 0
    @EnvironmentObject var mainEnvObj : MainEnvObj
    
    var body: some View {
        TabbedView(selection: $selection){
            //Home()//.environmentObject(mainEnvObj)
            Home()
                .tabItem({
                    selection == 0 ?
                        Image(systemName: "house.fill")
                            .imageScale(.large) :
                        Image(systemName: "house")
                            .imageScale(.large)
                    Text("Home")
                })
                .tag(0)
            
            //CreateMain().environmentObject(mainEnvObj)
            //CreateMain()
                Text("hey")
                .tabItem({
                    selection == 1 ?
                        Image(systemName: "plus.square.fill")
                            .imageScale(.large) :
                        Image(systemName: "plus.square")
                            .imageScale(.large)
                    Text("New")
                })
                .tag(1)
            
            Text("hey")
                
                .tabItem({
                    selection == 2 ?
                        Image(systemName: "questionmark.diamond.fill")
                            .imageScale(.large) :
                        Image(systemName: "questionmark.diamond")
                            .imageScale(.large)
                    Text("Feedback")
                })
                .tag(2)
            
        }.environmentObject(mainEnvObj)
    }
}

#if DEBUG
struct TabbedMain_Previews : PreviewProvider {
    static var previews: some View {
        TabbedMain().environmentObject(MainEnvObj())
    }
}
#endif
