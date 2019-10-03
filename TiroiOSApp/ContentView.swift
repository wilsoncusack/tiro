//
//  ContentView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    //@State private var selection = 0
    @EnvironmentObject var mainEnv : MainEnvObj
 
    var body: some View {
            Main()//.environmentObject(mainEnvObj)
//            .background(Color.init(red: 0.92, green: 0.92, blue: 0.95))
            
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MainEnvObj())
    }
}
#endif
