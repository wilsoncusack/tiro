//
//  Main.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

struct Main : View {
    var data = DemoData()
    @EnvironmentObject var mainEnv : MainEnvObj
    
    
    var body: some View {
        VStack{
            if(mainEnv.userStore.user != nil && mainEnv.userStore.user!.has_finished_setup){
                
                TabbedMain()
               // Home()
                
            } else if(mainEnv.userStore.user == nil){
                Landing().environmentObject(mainEnv)
            } else {
                NavigationView{
                AddLearners().environmentObject(mainEnv)
                }
            }
        }
    }
    
}

#if DEBUG
struct Main_Previews : PreviewProvider {
    static var previews: some View {
        Main().environmentObject(MainEnvObj())
    }
}
#endif
