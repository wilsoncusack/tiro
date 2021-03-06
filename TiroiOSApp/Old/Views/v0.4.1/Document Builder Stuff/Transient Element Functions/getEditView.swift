//
//  getEditView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine
import YPImagePicker

//extension TransientDocumentElement {
//    
//    var editView: AnyView{
//        switch self.value{
//        case .string(let value, let displayType, let editType):
//            switch displayType {
//             case .text:
//                return AnyView(
//                        TextViewEditable(str: value, onChange: {s in
//                            self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                            
//                        }, isFirstResponer: false).frame(height: 300)
//                )
//             case .caption:
//                return AnyView(
//                        TextViewEditable(str: value, onChange: {s in
//                            self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                            
//                        }, isFirstResponer: false).frame(height: 150)
//                )
//             case .quote:
//                return AnyView(
//                        TextViewEditable(str: value, onChange: {s in
//                            self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                            
//                        }, isFirstResponer: false).frame(height: 150)
//                )
//            }
//        case .int(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .date(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .picker(let value, let displayType, let editType):
//            return getPickerEditView(pickerStruct: value, displayType: displayType, editType: editType)
//            return AnyView(EmptyView())
//        case .documentValue(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .images(let value, let displayType, let creatType, let editType):
//            switch editType{
//                
//            case .images:
//                var picker = ImagePickerObject2(tEl: self, images: value)
//
//                var view = YPCreate2(obj: picker, showModal: false)
//                return AnyView(view)
//            }
//             case .pdf(let value, let displayType, let creatType, let editType):
//            return AnyView(EmptyView())
//        }
//    }
//    
//    var createView: some View{
//        switch self.value{
//            
//        case .string(let value, let displayType, let editType):
//             switch displayType {
//             case .text:
//                return AnyView(
//                        TextViewEditable(str: value, onChange: {s in
//                            self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                            
//                        }, isFirstResponer: false).frame(height: 300)
//                )
//             case .caption:
//                return AnyView(
//                        TextViewEditable(str: value, onChange: {s in
//                            self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                            
//                        }, isFirstResponer: false).frame(height: 150)
//                )
//             case .quote:
//                return AnyView(
//                        TextViewEditable(str: value, onChange: {s in
//                            self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                            
//                        }, isFirstResponer: false).frame(height: 150)
//                )
//            }
//        case .int(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .date(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .picker(let value, let displayType, let editType):
//             return getPickerEditView(pickerStruct: value, displayType: displayType, editType: editType)
////        case .document(let value, let displayType, let editType):
////            return AnyView(EmptyView())
//        case .documentValue(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .images(let value, let displayType, let createType, let editType):
//            switch createType{
//                            
//                        case .camera:
//                            return AnyView(EmptyView())
//                        case .photoLibrary:
//                            var picker = ImagePickerObject2(tEl: self, images: value)
//
//                            var view = YPCreate2(obj: picker, showModal: true)
//                            return AnyView(view)
//                        }
//        case .pdf(let value, let displayType, let createType, let editType):
//            var s = ScanObject(tEl: self, aValue: value.pdfDocument, saveFunction: {pdfDocument in
//                print("save function called")
//                self.value = Value.pdf(value: PDFDocumentWrapper(data: pdfDocument.dataRepresentation()!), displayType: displayType, createType: createType, editType: editType)
//            })
//            return AnyView(ScanEdit(scanObj: s))
//            //AnyView(EmptyView())
//        }
//    }
//    
//    func getEditView() -> AnyView{
//        switch self.value{
//        case .string(let value, let displayType, let editType):
//            return  AnyView(
//                VStack{
//                    TextViewEditable(str: value, onChange: {s in
//                        //                        print("str in enum: \(s)")
//                        //self.value
//                        self.value = Value.string(value: s, displayType: displayType, editType: editType)
//                        
//                    })
//                }
//            )
//        case .data(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .int(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .date(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//        case .picker(let value, let displayType, let editType):
//            return getPickerEditView(pickerStruct: value, displayType: displayType, editType: editType)
//        case .document(let value, let displayType, let editType):
//            return AnyView(EmptyView())
//          case .dataArray(let value, let displayType, let createType, let editType):
//            return AnyView(EmptyView())
//        }
//        
//        
//    }
    
    
//}
//
//extension TransientDocumentElement {
//    func getPickerEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
//        if(pickerStruct.isCoreData){
//            switch pickerStruct.coreDataType!{
//            case .learner:
//                return getLearnerEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
//            case .tag:
//                return getTagEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
//                
//            }
//        } else {
//            return AnyView(EmptyView())
//        }
//    }
    
//    func getTagEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
//        let tags = pickerStruct.selected
//            .map {getTagByID(id: $0)}
//            .filter {$0 != nil}
//            .map {$0!}
//        let selectionManager = GenericSelectionManager(tags)
//        var editableGeneric = ValueEditableGeneric(value: selectionManager.$selected, update: { tags in
//            print("in nested update")
//
//             var new = Array(tags).map {$0.id.description}
//            print("new: \(new)")
//            self.value = Value.picker(
//                                value: PickerStruct(
//                                    selected: new,
//                                    allowedChoices: pickerStruct.allowedChoices,
//                                    isCoreData: pickerStruct.isCoreData,
//                                    coreDataType: pickerStruct.coreDataType,
//                                    choices: pickerStruct.choices),
//                                displayType: displayType,
//                                editType: editType)
//
//        })
//        return AnyView(TagPicker(obj: editableGeneric, pickerManager: selectionManager))
////        return AnyView(TagPicker(pickerManager: selectionManager))
//    }
//
//
//    func getLearnerEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
//        let learners = pickerStruct.selected
//            .map {getLearnerByID(id: $0)}
//            .filter {$0 != nil}
//            .map {$0!}
//        let selectionManager = GenericSelectionManager(learners)
//        selectionManager.$selected
//            .receive(on: RunLoop.main)
//            .sink { (learnerSet) in
//                let new = Array(learnerSet).map {$0.id.description}
//                self.value = Value.picker(
//                    value: PickerStruct(
//                        selected: new,
//                        allowedChoices: pickerStruct.allowedChoices,
//                        isCoreData: pickerStruct.isCoreData,
//                        coreDataType: pickerStruct.coreDataType,
//                        choices: pickerStruct.choices),
//                    displayType: displayType,
//                    editType: editType)
//        }
//        return AnyView(LearnerPicker(pickerManager: selectionManager, editableObj: <#ObservableValue<Set<Learner>>#>))
//    }
//}



