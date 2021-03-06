//
//  ProfileImage.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ProfileImage : View {
    @ObservedObject var learner: Learner
    var size : CGFloat
    var body: some View {
        Group{
        if(learner.image != nil){
            DisplayUIImage(uiImageData: learner.image!)
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else if (learner.profile_image_name != nil) {
            
        Image(learner.profile_image_name!)
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
//            Button(action: {
//                AppDelegate.shared.persistentContainer.viewContext.delete(self.learner)
//            }){Text("Delete")}
        } else{
//            EmptyView()
            Button(action: {
                AppDelegate.shared.persistentContainer.viewContext.delete(self.learner)
            }){Text("Delete")}
            }
        }
    }
}

#if DEBUG
//struct ProfileImage_Previews : PreviewProvider {
//    static var previews: some View {
//        ProfileImage(imageName : "rabbit", size: 100)
//    }
//}
#endif
