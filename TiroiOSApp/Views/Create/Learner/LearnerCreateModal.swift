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
     @State var image : UIImage? = nil
    @State var presentImagePicker : Bool = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Form{
                    TextField("Learner name", text: $name)
                        .padding(.leading, 15)
                    Section(header: Text("Choose a profile image")){
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .top){
                                
                                ForEach(mainEnv.icons){icon in
                                    // self.profileImageMaker(icon: icon)
                                    Image(icon.image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
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
                    Section(header: Text("Or add your own")){
                        if(image != nil) {
                        HStack{
                            DisplayUIImage(uiImageData: image!.jpegData(compressionQuality: 1)!)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            Button(action: {
                                self.presentImagePicker = true
                                self.image = nil
                            }){
                                Text("Add Photo")
                            }
                        }
                        
                    } else {
                        
                        Button(action: {
                            self.presentImagePicker = true
                            self.image = nil
                        }){
                            Text("Add Photo")
                        }
                    }
                        }.sheet(isPresented: $presentImagePicker) {
                            ImagePicker(showModal: self.$presentImagePicker, image: self.$image)
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
                    if(self.name != "" && (self.selectedIcon != "" || self.image != nil)){
                        self.mainEnv.createLearner(name: self.name, profile_image_name: self.selectedIcon, image: self.image?.jpegData(compressionQuality: 1))
                        self.showModal = false
                        self.name = ""
                        self.selectedIcon = ""
                    }
                    
                }){
                    Text("Save")
                }.foregroundColor(self.name == "" || (self.selectedIcon == "" && self.image == nil) ? .gray : .blue)
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
