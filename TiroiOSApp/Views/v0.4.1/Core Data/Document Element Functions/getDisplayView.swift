//
//  getDisplayView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

extension Document_Element{
    var displayView: some View {
        if(self.value == nil){
            print("value is nil")
            return AnyView(EmptyView())
        } else {
            switch self.value!{
                
            case .string(let value, let displayType, let editType):
                return AnyView(Text(value).padding(.all, 15))
            case .data(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .int(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .date(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .picker(let value, let displayType, let editType):
                return getPickerDisplay(pickerStruct: value, displayType: displayType, editType: editType)
            case .documentWrapper(let value, let displayType, let editType):
                print("in document wrapper")
                return AnyView(value.document.dayView)
              case .dataArray(let value, let displayType, let createType, let editType):
                print("in data array")
                switch displayType{
                    
                case .images:
                    print("in display this image")
                    return AnyView(
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(value.map {getImageFromData(data: $0)}, id: \.self){i in
                            Image(uiImage: i).resizable().scaledToFit()
                        }
                            }
                        }.frame(height: 200))
                    
                }
               // return AnyView(EmptyView())
            case .images(let value, let displayType, let createType, let editType):
                switch displayType{
                    
                case .images:
                    print("in display this image")
                    return AnyView(
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(value.map {$0.uiImage}, id: \.self){i in
                            Image(uiImage: i)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width)
                                //.scaledToFit()
                        }
                            }
                        })
                    
                }
            }
        }
    }
}

extension Document_Element{
    func getPickerDisplay(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView{
        print("in get picker display")
        print(pickerStruct)
        if(pickerStruct.isCoreData){
            switch pickerStruct.coreDataType!{
                
            case .learner:
                return AnyView(
                    ForEach(pickerStruct.selected, id: \.self){id in
                        Text(getLearnerByID(id: id)!.name)
                            .foregroundColor(.secondary)
                        .padding()
                    }
                )
            case .tag:
                return AnyView(EmptyView())
            }
        } else {
        return AnyView(EmptyView())
        }
    }
}

func getPickerDisplay(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView{
       print("in get picker display")
       print(pickerStruct)
       if(pickerStruct.isCoreData){
           switch pickerStruct.coreDataType!{
               
           case .learner:
               return AnyView(
                   ForEach(pickerStruct.selected, id: \.self){id in
                       Text(getLearnerByID(id: id)!.name)
                           .foregroundColor(.secondary)
                       .padding()
                   }
               )
           case .tag:
               return AnyView(EmptyView())
           }
       } else {
       return AnyView(EmptyView())
       }
   }
