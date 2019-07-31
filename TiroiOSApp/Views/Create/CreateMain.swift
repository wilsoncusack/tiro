//
//  CreateMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct CreateMain : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @State var dummyShowModal = false
    @Binding var tabSelection : Int
    
    func navigateHome() {
        self.tabSelection = 0
    }
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(
                destination: ActivityCreateDetailView(showModal: $dummyShowModal, activity: nil, done: navigateHome)){
                    CreationRowView(
                        title : "Activity",
                        description: "Record an Activity",
                        image: Image(systemName: "text.badge.star")
                    )
                }
                NavigationLink(
                    destination: QuestionCreateDetailView()){
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
