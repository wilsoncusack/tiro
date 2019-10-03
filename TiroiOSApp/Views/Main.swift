//
//  Main.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

//class Test2 : ObservableObject {
//    @FetchRequest(fetchRequest: User.fetchRequest())
//    var fetchedResults1: FetchedResults
//    public var users : [User] {
//        return fetchedResults1 ?? []
//    }
//
//    @FetchRequest(fetchRequest: Learner.fetchRequest())
//    var fetchedResults2: FetchedResults
//    public var learners : [Learner] {
//        return fetchedResults2 ?? []
//    }
//}

struct Main : View {
    var data = DemoData()
    @EnvironmentObject var mainEnv : MainEnvObj
    @State var showUser = true
    //var test = Test2()

    
    
    
    
    var body: some View {
        VStack{
            if(!mainEnv.setupShowUserCreation && !mainEnv.setupShowLearnerCreation) {
                TabbedMain().edgesIgnoringSafeArea(.top)
            } else if(mainEnv.setupShowUserCreation){
                Landing()//.padding()
            }
            else {
                AddLearners()//.padding()
            }
        }
        //.padding(.top, 30)
//        .background(Color.init(red: 0.92, green: 0.92, blue: 0.95))
//            .edgesIgnoringSafeArea(.top)
//            .offset(y: -50)
    }
    
}

#if DEBUG
struct Main_Previews : PreviewProvider {
    static var previews: some View {
        Main().environmentObject(MainEnvObj())
    }
}
#endif
