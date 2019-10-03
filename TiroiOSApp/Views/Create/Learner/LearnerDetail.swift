//
//  LearnerDetail.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 9/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct LearnerDetail: View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal: Bool
    @ObservedObject var learner: Learner
    @State var presentImagePicker = false
    @State var image : UIImage? = nil
    
    
    var body: some View {
        //NavigationView{
            VStack{
                if(image == nil){
                    ProfileImage(learner: learner, size: 100)
                } else {
                    DisplayUIImage(uiImageData: image!.jpegData(compressionQuality: 1)!)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                }
                
                Button(action: {
                    self.presentImagePicker = true
                    self.image = nil
                }){
                    Text("Change Photo")
                }
                }.sheet(isPresented: $presentImagePicker) {
                    ImagePicker(showModal: self.$presentImagePicker, image: self.$image)
                }
            .navigationBarTitle(Text(learner.name), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.showModal = false
                }){Text("Cancel")}
                , trailing: Button(action: {
                    if(self.image != nil){
                        self.learner.objectWillChange.send()
                        self.learner.image = self.image!.jpegData(compressionQuality: 1)
                        self.mainEnv.learnerStore.saveChanges()
                        
                    }
                    self.showModal = false
                }){Text("Save")})
                
            
        }
   // }
}

//struct LearnerDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnerDetail()
//    }
//}
