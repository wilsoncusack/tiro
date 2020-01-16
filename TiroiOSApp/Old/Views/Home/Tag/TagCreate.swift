//
//  TagCreate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TagCreate: View {
    @ObservedObject var store: Store<TagState, TagAction>
    @Binding var showModal: Bool
    @State var tagName: String = ""
    var tagTypes: [TagType]
    
    func save(){
        if(!tagName.isEmpty){
            store.send(.create(name: tagName, tagType: tagTypes[0]))
            self.showModal = false
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    TextField("Tag Name", text: $tagName)
                }
                
            }
            .navigationBarTitle("Create Tag", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {self.showModal = false}){
                    Text("Cancel")
                }, trailing:
                Button(action: {self.save()}){
                                   Text("Save")
                }.disabled(tagName.isEmpty)
            )
        }
    }
}

//struct TagCreate_Previews: PreviewProvider {
//    static var previews: some View {
//        TagCreate()
//    }
//}
