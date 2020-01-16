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
    //@EnvironmentObject var mainEnv : MainEnvObj
    var tabSelection: Int
    @State var showUser = true
    @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        VStack{
            if(store.value.loggedInUser != nil
                && store.value.userHasFinishedSetup
                //&& !mainEnv.setupShowLearnerCreation
                ) {
                TabbedMain(selection: tabSelection, store: store).edgesIgnoringSafeArea(.top)
            }
            else if(store.value.loggedInUser == nil){
                Landing(store: store)
            }
            else if(!store.value.userHasFinishedSetup){
                AddLearners(store: store)
            }
        }
    }
    
}

