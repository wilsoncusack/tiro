//
//  ElementGenericDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//struct ElementGenericDetailView: View {
//    @ObservedObject var element: ElementLoadable
//    var widthOffset: CGFloat
//    
//    init(element: ElementLoadable, widthOffset: CGFloat){
//        self.element = element
//        self.widthOffset = widthOffset
//        self.element.loadAsync()
//    }
//    
//    var body: some View{
//        if(self.element.value == nil){
//            return AnyView(Text("Loading"))
//        } else {
//            return AnyView(DisplayView(widthOffset: widthOffset, value: self.element.value!))
//        }
//    }
//}

struct ElementDetailView: View{
    @ObservedObject var element: ElementLoadable
    
    init(element: ElementLoadable){
        self.element = element
        self.element.loadAsync()
    }
    var body: some View{
        Group{
        if(self.element.value == nil){
            ElementDetailViewLoading(type: element.element.type)
       } else {
            ElementDetailViewLoaded(value: element.value!)
       }
        }
    }
}

struct ElementDetailViewLoading: View {
    var type: ElementValueType
    
    var body: some View{
        switch type{
        case .string:
            return AnyView(EmptyView())
        case .date:
            return AnyView(EmptyView())
        case .int:
            return AnyView(EmptyView())
        case .picker:
            return AnyView(EmptyView())
        case .pdf:
            return AnyView(EmptyView())
        case .images:
            return AnyView(Rectangle().foregroundColor(Color(UIColor.systemGray6)))
        case .document:
            return AnyView(EmptyView())
        }
    }
}

struct ElementDetailViewLoaded: View {
    var value: Value
    
    var body: some View{
        switch value{
            
        case .string(let value, let displayType, let editType):
            switch displayType{
                
            case .text:
                return AnyView(
                    HStack{
                    Text(value)
                        .padding()
                        Spacer()
                    }
                )
                        
            case .caption:
                return AnyView(
                    HStack{
                        Text(value)
                            .font(.subheadline)
//                            .foregroundColor(.secondary)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        Spacer()
                })
            case .quote:
                 return AnyView(
                                    HStack{
                                        Text(value)
                                        
                                            .font(.subheadline)
                                        .italic()
                                            .lineLimit(nil)
                                            .frame(width:  UIScreen.main.bounds.width - 40)
                                        .scaledToFill()
//                                            .padding(.leading, 20)
//                                            .padding(.trailing, 20)
//                                            .padding(.top, 10)
                                        
                                        Spacer()
                                    }.padding(.leading, 20)
                                                                                .padding(.trailing, 20)
                                                                                .padding(.top, 10))
                
            }
            
        
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return AnyView(
                PickerDetailView(picker: value, displayMode: .detail).padding(.leading, 15)
            )
        case .documentValue(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let createType, let editType):
            return AnyView(GenericImagesView(images: value.map {$0.uiImage}, displayType: displayType, frameWidth: UIScreen.main.bounds.width).padding(.top, -20))
        case .pdf(let value, let displayType, let createType, let editType):
        
            return AnyView(
                PDFKitRepresentedView(pdfDoc: value.pdfDocument)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.29)
                    .padding(.top, -20)
            )
        }
    }
}

