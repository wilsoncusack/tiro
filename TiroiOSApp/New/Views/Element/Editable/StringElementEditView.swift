//
//  StringElement.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

//func getStringElementEditView(editableObj: ObservableValue<String>, editType: StringEditDisplayType) -> AnyView {
//    switch editType{
//    case .textField:
//        return AnyView(TextFieldEditable(editableObject: editableObj))
//    case .textView:
//        return AnyView(TextViewEditable(editableObject: editableObj, isFirstResponer: false))
//    }
//}

struct StringElementEditView: View {
    var placeholder: String
    var editableObj: ObservableValue<String>
    var editType: StringEditDisplayType
    var keyboardType: UIKeyboardType
    
    var body: some View{
        switch editType{
        case .caption:
            return AnyView(TextViewEditable(placeholder: placeholder,editableObject: editableObj, isFirstResponder: false).frame(height: 150))
        case .quote:
            return AnyView(TextViewEditable(placeholder: placeholder,editableObject: editableObj, isFirstResponder: false).frame(height: 150))
        case .longText:
            return AnyView(TextViewEditable(placeholder: placeholder,editableObject: editableObj, isFirstResponder: false).frame(height: 300))
        case .shortText:
            return AnyView(TextFieldEditable(placeholder: placeholder, editableObject: editableObj, keyboardType: keyboardType))
        
            
        }
    }
}

struct TextFieldEditable: View {
    var placeholder: String
    @ObservedObject var editableObject: ObservableValue<String>
    var keyboardType: UIKeyboardType
    
    var body: some View{
        
        TextField(placeholder, text: $editableObject.value)
            .keyboardType(keyboardType)
    }
}

struct TextViewEditable: View {
    var placeholder: String
    @ObservedObject var editableObject: ObservableValue<String>
    @State var isFirstResponder: Bool
    
    var body: some View{
        VStack{
            if(isFirstResponder){
            HStack{
                Spacer()
                Button(action: {self.isFirstResponder = false}){
                    Text("Close Keyboard")
                }
            
            }
            }
           // Section{
            UITextViewRepresentable(placeholder: placeholder, text: $editableObject.value, isFirstResponder: $isFirstResponder)
               
               
            
      //  }
            }//.padding(.bottom, isFirstResponder ? 500 : 0)
    }
}
