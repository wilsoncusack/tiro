//
//  ElementRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ElementRowView: View{
    @ObservedObject var element: ElementLoadable
    
    init(element: ElementLoadable){
        self.element = element
        self.element.loadAsync()
        print("loading async")
    }
    var body: some View{
        Group{
        if(self.element.value == nil){
            ElementRowViewLoading(type: element.element.type)
       } else {
            ElementRowViewLoaded(value: element.value!)
       }
        }
    }
}

struct ElementRowViewLoading: View {
    var type: ElementValueType
    
    var body: some View{
        switch type{
        case .string:
            return AnyView(Rectangle()
            .foregroundColor(Color(UIColor.systemGray6))
            .frame(width: UIScreen.main.bounds.width - 115, height:  25))
        case .date:
            return AnyView(EmptyView())
        case .int:
            return AnyView(EmptyView())
        case .picker:
            return AnyView(EmptyView())
        case .pdf:
            return AnyView(Rectangle()
            .foregroundColor(Color(UIColor.systemGray6))
            .frame(width: UIScreen.main.bounds.width - 115, height:  UIScreen.main.bounds.width - 115))
        case .images:
            return AnyView(Rectangle()
                .foregroundColor(Color(UIColor.systemGray6))
                .frame(width: UIScreen.main.bounds.width - 115, height:  UIScreen.main.bounds.width - 115))
        case .document:
            return AnyView(EmptyView())
        }
    }
}

struct ElementRowViewLoaded: View {
    var value: Value
    
    var body: some View{
        switch value{
            
        case .string(let value, let displayType, let editType):
            switch displayType{
                
            case .text:
                return AnyView(
                    Text(value)
                        //.foregroundColor(.secondary)
                        .font(.subheadline)
                )
            case .caption:
                return AnyView(
                    Text(value)
                        .font(.subheadline)
                        //.foregroundColor(.secondary)
                )
                
            case .quote:
                print("in quote")
                           return AnyView(
                               Text(value)
                                   .font(.subheadline)
                            .italic()
                                   //.foregroundColor(.secondary)
                           )
            }
            
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .documentValue(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let createType, let editType):
            return AnyView(GenericImagesView(images: value.map {$0.uiImage}, displayType: displayType, frameWidth: UIScreen.main.bounds.width - 115))
        case .pdf(let value, let displayType, let createType, let editType):
            var width = UIScreen.main.bounds.width - 115
            return AnyView(
                PDFKitRepresentedView(pdfDoc: value.pdfDocument)
                    .frame(width: width, height: width * 1.29)
                   // .padding(.top, -20)
            )
        }
    }
}
