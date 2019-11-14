//
//  ImageCreate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/8/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ImageCreate: View {
    @State var image : Data? = nil
    @State var dummyModal = true
    @State var dummyDate = Date()
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        NavigationView{
            Form{
                
                if(image != nil){
                    Image(uiImage: UIImage(data: image!)!)
                        .resizable()
                        .scaledToFit()
                    Button(action: {
                        //self.image = nil
                        self.dummyModal = true
                    }){
                        Text("Change Image")
                    }
                    
                    Text("Caption")
                } else {
                    EmptyView()
                }
            }.sheet(isPresented: $dummyModal){
                ImagePicker(showModal: self.$dummyModal, image: self.$image, imageDate: self.$dummyDate)
            }
            .navigationBarTitle("Add Photo", displayMode: .inline)
        }
    }
}

struct ImageCreate_Previews: PreviewProvider {
    static var previews: some View {
        ImageCreate()
    }
}
