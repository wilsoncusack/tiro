//
//  EditableElementView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

struct EditableElementView: View {
    var element: DocumentElementEditable
    
    var body: some View{
        switch element.localValue{
            
        case .string(let value, let displayType, let editType):
            let observed = ObservableValue<String>(value: value){str in
                self.element.localValue = Value.string(value: str, displayType: displayType, editType: editType)
              
            }
            return AnyView(StringElementEditView(editableObj: observed, editType: editType))
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return getPickerEditView(editableElement: self.element, pickerStruct: value, displayType: displayType, editType: editType)
        case .documentValue(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let createType, let editType):
            return AnyView(EmptyView())
        case .pdf(let value, let displayType, let createType, let editType):
            return AnyView(EmptyView())
        }
    }
}
