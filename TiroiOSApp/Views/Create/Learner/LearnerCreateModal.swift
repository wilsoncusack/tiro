//
//  LearnerCreateModal.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct LearnerCreateModal : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    @State var name = ""
    @State var selectedIcon : String = ""
//    var icons : [icon] {
//
//    }
    
//    func profileImageMaker(icon: Icon) -> some View {
//        if(icon.image == self.selectedIcon){
//           return ProfileImage(imageName: icon.image, size : 100) .overlay(Circle().stroke(Color.black, lineWidth: 4))
//            .tapAction {
//                    self.selectedIcon = ""
//            }
//        } else {
//          return ProfileImage(imageName: icon.image, size : 100)
//            .overlay(Circle().stroke(Color.black, lineWidth: 0))
//            .tapAction {
//                self.selectedIcon = icon.image
//
//            }
//        }
//    }
//    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Form{
                    TextField("Learner name", text: $name)
                        .padding(.leading, 15)
                    Section(header: Text("Profile Image")){
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .top){

                                ForEach(mainEnv.icons){icon in
                                   // self.profileImageMaker(icon: icon)
                                    ProfileImage(imageName: icon.image, size : 100)
                                        .overlay(Circle().stroke(Color.black, lineWidth: icon.image == self.selectedIcon ? 4 : 0))
                                        .onTapGesture {
                                            self.selectedIcon = icon.image
//                                            icon.image == self.selectedIcon ? self.selectedIcon = "" : self.selectedIcon =
                                        }
                                }

                            }.frame(height: 108)
                                .padding(.leading, 15)
                                .padding(.trailing, 15)
                        }
                    }
                }
            }
            .navigationBarTitle("Create Learner", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action : {self.showModal.toggle()}){
                        Text("Cancel")
                    }
                    ,trailing:
                    Button(action : {
                        if(self.name != "" && self.selectedIcon != ""){
                            self.mainEnv.createLearner(name: self.name, profile_image_name: self.selectedIcon)
                            self.showModal = false
                            self.name = ""
                            self.selectedIcon = ""
                        }
                        
                    }){
                        Text("Save")
                    }.foregroundColor(self.name == "" || self.selectedIcon == "" ? .gray : .blue)
            )
        }
    }
}

#if DEBUG
struct LearnerCreateModal_Previews : PreviewProvider {
    @State static var showModal = false
    static var previews: some View {
        //        LearnerCreateModal(showModal: $showModal).environmentObject(MainEnvObj())
        AddLearners().environmentObject(MainEnvObj())
    }
}
#endif
