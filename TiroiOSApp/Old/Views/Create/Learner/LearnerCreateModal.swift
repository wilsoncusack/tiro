//
//  LearnerCreateModal.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct LearnerCreateModal : View {
    //@EnvironmentObject var mainEnv : MainEnvObj
    @ObservedObject var store: Store<LearnerState, LearnerAction>
    @Binding var showModal : Bool
    @State var name = ""
    @State var selectedIcon : String = ""
     @State var image : Data? = nil
    @State var presentImagePicker : Bool = false
    @State var throwAwayDate: Date = Date()
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Form{
                    TextField("Learner name", text: $name)
                        .padding(.leading, 15)
                    Section(header: Text("Choose a profile image")){
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack(alignment: .top){
                                
                                ForEach(systemProfileIcons){icon in
                                    // self.profileImageMaker(icon: icon)
                                    Image(icon.image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.black, lineWidth: icon.image == self.selectedIcon ? 4 : 0))
                                        .onTapGesture {
                                            self.selectedIcon = icon.image
//                                            self.image = UIImage(imageLiteralResourceName: icon.image).jpegData(compressionQuality: 0.8)
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
                            DisplayUIImage(uiImageData: image!)
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
                            ImagePicker(showModal: self.$presentImagePicker, image: self.$image, imageDate: self.$throwAwayDate)
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
                        if(self.selectedIcon != "" && self.image == nil){
                            self.image = UIImage(imageLiteralResourceName: self.selectedIcon).jpegData(compressionQuality: 0.8)
                        }
                        self.store.send(.create(name: self.name, image: self.image))
                        self.showModal = false
                        self.name = ""
                        self.selectedIcon = ""
                    }
                    
                }){
                    Text("Save")
                }.foregroundColor(self.name == "" || (self.selectedIcon == "" && self.image == nil) ? .gray : .blue)
            )
        }.navigationViewStyle(StackNavigationViewStyle())
        }

    
}


