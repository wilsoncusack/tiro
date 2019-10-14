//
//  LearnerDetail.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 9/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct LearnerDetail: View {
   // @Binding var showModal: Bool
    @ObservedObject var store: Store<LearnerState, LearnerAction>
    @State var name: String
    @State var image: Data?
    @ObservedObject var learner: Learner
    
    @State var presentImagePicker = false
    @State var throwAwayDate : Date = Date()
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        //NavigationView{
            VStack{
                if(image == nil){
                    ProfileImage(learner: learner, size: 100)
                } else {
                    DisplayUIImage(uiImageData: image!)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                }
                
                Button(action: {
                    self.presentImagePicker = true
                    self.image = nil
                }){
                    Text("Change Photo")
                }
                TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                Spacer()
//                Button(action: {
//                     self.presentationMode.wrappedValue.dismiss()
//                    AppDelegate.shared.persistentContainer.viewContext.delete(self.learner)
//                    AppDelegate.shared.saveContext()
//                }){
//                    Text("Delete")
//                        .foregroundColor(.red)
//                }.padding(.top, 40)
                
                }.sheet(isPresented: $presentImagePicker) {
                    ImagePicker(showModal: self.$presentImagePicker, image: self.$image, imageDate: self.$throwAwayDate)
                }
        
            .navigationBarTitle(Text(learner.name), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.store.send(.edit(learner: self.learner, name: self.name, image: self.image))
                        self.presentationMode.wrappedValue.dismiss()
                   // self.showModal = false
                }){Text("Save")})
        .navigationBarHidden(false)
            
        }
   // }
}

//struct LearnerDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnerDetail()
//    }
//}
