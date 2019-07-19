//
//  Home.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

struct Home : View {
    //var demoData = DemoData1()
    @EnvironmentObject var mainEnv : MainEnvObj
    @State var showActivityModal = false
    @State var selectedActivity : Activity = nil
//    var activityModal : Modal? {
//        if(showActivityModal){
//        
//
//           return Modal(ActivityDetailView(activity: selectedActivity!, showModal: $showActivityModal), onDismiss: {self.showActivityModal = false})
//        } else {
//           return nil
//        }
//    }
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                Divider().padding(.leading, 15)
                VStack(alignment: .leading) {
                    Text("Activities")
                        .font(.system(size: 22))
                        .bold()
                        .padding(.leading, 15)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10){
                            ForEach(mainEnv.activityStore.activities){ activity in
                                ActivityCard(activity: activity) .tapAction({
                                    self.selectedActivity = activity
                                    self.showActivityModal = true
                                })
                            }
                        }.frame(height:230).padding(.leading, 15)
                    }.padding(.bottom,20)//.offset(x: -10)
                }
                
            }.sheet(isPresented: $showActivityModal, content: {ActivityDetailView(activity: self.selectedActivity!, showModal: self.$showActivityModal)})
            
               // .presentation(activityModal)
            .navigationBarTitle("Home")
            //.padding(.leading, 15)
        }
        
    }
    
}

func setup(){
    
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var data = DemoData()
    //_ = print("hey")
    static var previews: some View {
        Home().environmentObject(MainEnvObj())
    }
}
#endif
