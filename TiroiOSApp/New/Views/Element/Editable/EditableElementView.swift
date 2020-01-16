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
    var is_create: Bool
    
    var body: some View{
        switch element.localValue{
            
        case .string(let value, let displayType, let editType):
            let observed = ObservableValue<String>(value: value.string){str in
                var new = value
                new.string = str
                self.element.localValue = Value.string(value: new, displayType: displayType, editType: editType)
              
            }
            return AnyView(StringElementEditView(placeholder: value.placeholder, editableObj: observed, editType: editType, keyboardType: .default))
        case .int(let value, let displayType, let editType):
            let observed = ObservableValue<String>(value: value < 0 ? "" : value.description){str in
               
                self.element.localValue = Value.int(value: (Int(str) ?? -1), displayType: displayType, editType: editType)
              
            }
            var placeholder = value < 0 ? "Duration in minutes ..." : value.description
            return AnyView(
//                Section(header: Text("How long did you read for?")){
                StringElementEditView(placeholder: placeholder, editableObj: observed, editType: .shortText, keyboardType: .numberPad)
//                }
            )
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return getPickerEditView(editableElement: self.element, pickerStruct: value, displayType: displayType, editType: editType)
        case .documentValue(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let createType, let editType):
//            return AnyView(EmptyView())
            var d = Date()
            
            var obj = ObservableValue<EditImageObject>(value: EditImageObject(images: value, date: d)){obj in
               // self.element.documentEditable.documentLoadable.document.date = obj.date
                var date = self.element.documentEditable.editableElements.filter {
                    $0.elementLoadable.element.type == .date
                }
                if(date.count > 0){
                    date[0].localValue = Value.date(value: obj.date, displayType: .basic, editType: .full)
                }
                self.element.documentEditable.dummyDate = obj.date
                print("setting image to \(obj.date.description)")
                self.element.localValue = Value.images(value: obj.images, displayType: displayType, createType: createType, editType: editType)
            }
            return AnyView(YPCreate2(obj: obj, showModal: is_create && self.element.elementLoadable.element.document.type == .image))
        case .pdf(let value, let displayType, let createType, let editType):
            return AnyView(PDFElementEditable(value: value, displayType: displayType, createType: createType, editType: editType, element: self.element))
            
        case let .bool(value, displayType, createType, editType):
            let observed = ObservableValue<Bool>(value: value){new in
                self.element.localValue = Value.bool(value: new, displayType: displayType, createType: createType, editType: editType)
              
            }
            return AnyView(
                BoolEditableView(title: "Done", value: observed)
            )
        }
    }
}

//func getImageEditView(element: DocumentElementEditable) -> AnyView {
//
//
//        var d = element.elementLoadable.element.date_created
//                   var obj = ObservableValue<([ImageWrapper], Date)>(value: (value, d)){touple in
//                       self.element.documentEditable.documentLoadable.document.date = touple.1
//                       print("setting image to \(touple.1.description)")
//                       self.element.localValue = Value.images(value: touple.0, displayType: displayType, createType: createType, editType: editType)
//                   }
//                   return AnyView(YPCreate2(obj: obj, showModal: is_create && self.element.elementLoadable.element.document.type == .image))
//
//
//}
