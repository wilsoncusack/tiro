//
//  EditableElementCreateView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//struct EditableElementCreateView: View {
//    var element: DocumentElementEditable
//    
//    var body: some View{
//        switch element.localValue{
//            
//        case .string(let value, let displayType, let editType):
//            let observed = ObservableValue<String>(value: value.string){str in
//                var new = value
//                new.string = str
//                self.element.localValue = Value.string(value: new, displayType: displayType, editType: editType)
//                self.element.localValue = Value.string(value: new, displayType: displayType, editType: editType)
//              
//            }
//            return AnyView(StringElementEditView(placeholder: value.placeholder, editableObj: observed, editType: editType))
//        case .int(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .date(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .picker(let value, let displayType, let editType):
//            return getPickerEditView(editableElement: self.element, pickerStruct: value, displayType: displayType, editType: editType)
//        case .documentValue(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .images(let value, let displayType, let createType, let editType):
//            var obj = ObservableValue<[ImageWrapper]>(value: value){imgArray in
//                self.element.localValue = Value.images(value: imgArray, displayType: displayType, createType: createType, editType: editType)
//            }
//            return AnyView(YPCreate2(obj: obj, showModal: true))
////            switch createType{
////
////                                    case .camera:
////                                        return AnyView(EmptyView())
////                                    case .photoLibrary:
////                                        var picker = ImagePickerObject2(tEl: self, images: value)
////
////                                        var view = YPCreate2(obj: picker, showModal: true)
////                                        return AnyView(view)
////                                    }
//        case .pdf(let value, let displayType, let createType, let editType):
////            var observed =
////            }
////            var s = ScanObject(tEl: self, aValue: value.pdfDocument, saveFunction: {pdfDocument in
////                            print("save function called")
////                            self.value = Value.pdf(value: PDFDocumentWrapper(data: pdfDocument.dataRepresentation()!), displayType: displayType, createType: createType, editType: editType)
////                        })
////                        return AnyView(ScanEdit(scanObj: s))
//            
//            return AnyView(PDFElementEditable(value: value, displayType: displayType, createType: createType, editType: editType, element: self.element))
//        }
//    }
//}
