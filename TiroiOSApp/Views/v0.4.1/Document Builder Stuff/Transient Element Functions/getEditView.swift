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

extension TransientDocumentElement {
    
    var editView: AnyView{
        switch self.value{
        case .string(let value, let displayType, let editType):
            return  AnyView(
                VStack{
                    TextViewEditable(str: value, onChange: {s in
                        //                        print("str in enum: \(s)")
                        //self.value
                        self.value = Value.string(value: s, displayType: displayType, editType: editType)
                        
                    }, isFirstResponer: self.documentElement.document.type == .text)
                }
            )
        case .data(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return getPickerEditView(pickerStruct: value, displayType: displayType, editType: editType)
//        case .document(let value, let displayType, let editType):
//            return AnyView(EmptyView())
            // case .dataArray(let value, let displayType, let createType, let editType):
            //return AnyView(EmptyView())
        case .dataArray(let value, let displayType, let createType, let editType):
            return AnyView(EmptyView())
        case .documentWrapper(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let creatType, let editType):
            switch editType{
                
            case .images:
                var picker = ImagePickerObject2(tEl: self, images: value)

                var view = YPCreate2(obj: picker, showModal: false)
                return AnyView(view)
            }
        }
    }
    
    var createView: some View{
        switch self.value{
            
        case .string(let value, let displayType, let editType):
            return AnyView(
               // Section{
                    TextViewEditable(str: value, onChange: {s in
                        //                        print("str in enum: \(s)")
                        //self.value
                        self.value = Value.string(value: s, displayType: displayType, editType: editType)
                        
                    }, isFirstResponer: self.documentElement.document.type == .text)
                //}
            )
        case .data(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .dataArray(let value, let displayType, let createType, let editType):
            switch createType{
                
            case .camera:
                return AnyView(EmptyView())
            case .photoLibrary:
                var picker = ImagePickerObject(images: value)
//                picker.$images
//                    .receive(on: RunLoop.main)
//                    .sink { (dataArr) in
//                    print("setting value: \(dataArr.count)")
//
//                    self.value = Value.dataArray(value: dataArr, displayType: displayType, createType: createType, editType: editType)
//                }
                var view = YPCreate(obj: picker, showModal: true)
                return AnyView(view)
            }
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
             return getPickerEditView(pickerStruct: value, displayType: displayType, editType: editType)
//        case .document(let value, let displayType, let editType):
//            return AnyView(EmptyView())
        case .documentWrapper(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let createType, let editType):
            switch createType{
                            
                        case .camera:
                            return AnyView(EmptyView())
                        case .photoLibrary:
                            var picker = ImagePickerObject2(tEl: self, images: value)

                            var view = YPCreate2(obj: picker, showModal: true)
                            return AnyView(view)
                        }
        }
    }
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
    
    
}

extension TransientDocumentElement {
    func getPickerEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
        if(pickerStruct.isCoreData){
            switch pickerStruct.coreDataType!{
            case .learner:
                return getLearnerEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
            case .tag:
                return getTagEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
                
            }
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func getTagEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
        let tags = pickerStruct.selected
            .map {getTagByID(id: $0)}
            .filter {$0 != nil}
            .map {$0!}
        let selectionManager = GenericSelectionManager(tags)
        print("in get tag edit view")
        // hmm, find a way to cancel this
        // maybe put it in the view and de-init
        // when we need to?
        // or otherwise pass something bindable
        // in 
        var x = selectionManager.$selected
            .receive(on: RunLoop.main)
            .sink { (tagSet) in
                
                var new = Array(tagSet).map {$0.id.description}
                print("in sink: \(new)")
                self.value = Value.picker(
                    value: PickerStruct(
                        selected: new,
                        allowedChoices: pickerStruct.allowedChoices,
                        isCoreData: pickerStruct.isCoreData,
                        coreDataType: pickerStruct.coreDataType,
                        choices: pickerStruct.choices),
                    displayType: displayType,
                    editType: editType)
        }
        return AnyView(TagPicker(pickerManager: selectionManager))
    }
    
    
    func getLearnerEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
        let learners = pickerStruct.selected
            .map {getLearnerByID(id: $0)}
            .filter {$0 != nil}
            .map {$0!}
        let selectionManager = GenericSelectionManager(learners)
        selectionManager.$selected
            .receive(on: RunLoop.main)
            .sink { (learnerSet) in
                let new = Array(learnerSet).map {$0.id.description}
                self.value = Value.picker(
                    value: PickerStruct(
                        selected: new,
                        allowedChoices: pickerStruct.allowedChoices,
                        isCoreData: pickerStruct.isCoreData,
                        coreDataType: pickerStruct.coreDataType,
                        choices: pickerStruct.choices),
                    displayType: displayType,
                    editType: editType)
        }
        return AnyView(LearnerPicker(pickerManager: selectionManager))
    }
}



