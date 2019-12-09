//
//  CreateMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct CreateMain : View {
    //@EnvironmentObject var mainEnv : MainEnvObj
    @ObservedObject var store: Store<AppState, AppAction>
    @Binding var tabSelection : Int
    
    func navigateHome() {
        self.tabSelection = 2
    }
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(
                destination: ActivityCreateDetailView(
                    store: self.store.view(
                        value: {$0.activityState},
                        action: {.activity($0)}),
                    done: navigateHome)){
                    CreationRowView(
                        title : "Activity",
                        description: "Record an Activity",
                        image: Image(systemName: "text.badge.star")
                    )
                }
                
                NavigationLink(
                    destination:
                    QuestionCreateDetailView(store:
                        self.store.view(value: {$0.questionState}, action: {.question($0)}), question: nil, done: navigateHome)){
                    CreationRowView(title : "Question", description: "Record a question to answer later", image: Image(systemName: "questionmark.circle"))
                }


                //QuestionCreateRowView()
            }
            .navigationBarTitle("New")
        }
    }
}

//#if DEBUG
//struct CreateMain_Previews : PreviewProvider {
//    static var previews: some View {
//        CreateMain().environmentObject(MainEnvObj())
//    }
//}
//#endif
