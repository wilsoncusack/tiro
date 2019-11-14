//
//  TextCreate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/8/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TextCreate: View{
    //@EnvironmentObject var docoument: Document
    @State var str = ""
    @State var isFirstResponder = true
    @Environment(\.presentationMode) var presentationMode
    @State var settime = false
    @State var date = Date()
    
    
    var body: some View{
        NavigationView{
            ScrollView{
            VStack{
                Form{
                    Section(header: Text("Optional")){
                        Text("Tags")
                        Text("Learners")
                        Toggle(isOn: $settime) {
                            Text("Manually Set Time")
                        }
                        if(settime){
                            DatePicker(selection: $date, displayedComponents: .hourAndMinute, label: {
                                Text("Time")
                            })
                        }
                    }
                    
                    Section(header: Text("Text")){
                        EmptyView()
//                        UITextField(text: $str, isFirstResponder: $isFirstResponder)
//                            .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                        //                    .padding(.top, 20)
                        //                    .padding(.leading, 15)
                        //                    .padding(.trailing, 15)
                    }
                    
                }
                
                Spacer()
            }.frame(height: UIScreen.main.bounds.height)
                //.frame(height: 600)
            }
               
            
            .navigationBarTitle("New Text", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                , trailing:
                Button(action: {
                    if(self.isFirstResponder){
                        self.isFirstResponder = false
                    } else {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }){
                    Text(self.isFirstResponder ? "Done" : "Save")
                }
                
            )
        }
        
        
    }
}

//struct TextCreate_Previews: PreviewProvider {
//    static var previews: some View {
//        //TextCreate()
//    }
//}
