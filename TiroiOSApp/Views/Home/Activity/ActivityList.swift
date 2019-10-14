//
//  ActivityList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ActivityRow: View {
    @ObservedObject var activity: Activity
    @Binding var showPhotos: Bool
    var photoWidth = UIScreen.main.bounds.width - 40
    var photoHeight : CGFloat {
        return photoWidth * 0.55
    }
    
    var body: some View{
        VStack(alignment: .leading){
            if(activity.image != nil && showPhotos){
                DisplayUIImage(uiImageData : activity.image!)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: photoWidth, height: photoHeight)
                    .cornerRadius(6)
            }
            
            Text(activity.title)
                .bold()
                .padding(.bottom, -10)
                
            HStack(alignment: .bottom){
                Text(longDateFormatter.string(from: activity.activity_date))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Spacer()
                LearnersPhotoOverlay(activity: activity).padding(.trailing, 15)
            }.frame(height: 30)
        }.padding(.top, 10).padding(.bottom, 10)
    }
}

struct ActivityList: View {
    @ObservedObject var store: Store<ActivityState, ActivityAction>
    var activities: [Activity]
    @State var showPhotos = true
    
    var body: some View{
        VStack{
            Picker(selection: $showPhotos, label: Text("")) {
                Text("Show Photos").tag(true)
                Text("Hide Photos").tag(false)
            }.pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)
                .padding()
            List(activities){activity in
                NavigationLink(destination: ActivityDetailView(store: self.store, activity: activity)){
                    ActivityRow(activity: activity, showPhotos: self.$showPhotos)
                }
            }
        }
        .navigationBarTitle("Activities", displayMode: .inline)
    }
}
