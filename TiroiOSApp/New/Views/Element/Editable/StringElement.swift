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
    var editableObj: ObservableValue<String>
    var editType: StringEditDisplayType
    
    var body: some View{
        switch editType{
        case .caption:
            return AnyView(TextViewEditable(editableObject: editableObj, isFirstResponer: false).frame(height: 150))
        case .quote:
            return AnyView(TextViewEditable(editableObject: editableObj, isFirstResponer: false).frame(height: 150))
        case .longText:
            return AnyView(TextViewEditable(editableObject: editableObj, isFirstResponer: false).frame(height: 300))
        case .shortText:
        return AnyView(TextFieldEditable(editableObject: editableObj))
        
            
        }
    }
}

struct TextFieldEditable: View {
    @ObservedObject var editableObject: ObservableValue<String>
    
    var body: some View{
        TextField("title", text: $editableObject.value)
    }
}

struct TextViewEditable: View {
    @ObservedObject var editableObject: ObservableValue<String>
    @State var isFirstResponer: Bool
    
    var body: some View{
        VStack{
            if(isFirstResponer){
            HStack{
                Spacer()
                Button(action: {self.isFirstResponer = false}){
                    Text("Close Keyboard")
                }
            
            }
            }
            Section{
                UITextViewRepresentable(text: $editableObject.value, isFirstResponder: $isFirstResponer)
            
        }
        }
    }
}
