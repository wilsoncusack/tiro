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
        if(element.value == nil){
            self.element.loadAsync()
        }
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
            
        case .bool:
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
                    Text(value.string)
                        //.foregroundColor(.secondary)
                        .font(.subheadline)
                )
            case .caption:
                return AnyView(
                    Text(value.string)
                        .font(.subheadline)
                    //.foregroundColor(.secondary)
                )
                
            case .quote:
                return AnyView(
                    Text(value.string)
                        .font(.subheadline)
                        .italic()
                    //.foregroundColor(.secondary)
                )
                
            case .bookTitle:
                return AnyView(
                    HStack{
                        //Text("Book:")
                        Text(value.string)
                            .italic()
                            .fontWeight(.semibold)
                    }
                )
            case .title:
                return AnyView(
                    HStack{
                        
                        Text(value.string)
//                            .fontWeight(.semibold)
                            .font(.subheadline)
                        .padding()
                            

                        
                           // .fontWeight(.bold)
                        Spacer()
                    }.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 0.4))
                )
            }
            
            
        case .int(let value, let displayType, let editType):
            switch displayType{
                
            case .dollars:
                return AnyView(EmptyView())
            case .minutes:
                return AnyView(
                    Group{
                    if(value == -1){
                    EmptyView()
                    } else {
                    Text("Duration: \(value.description) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    }
                )
                
            }
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            
            //            print("in picker")
            //            switch displayType{
            //
            //            case .basic:
            //                print("in basic")
            //                return AnyView(EmptyView())
            //            case .participants:
            //                print("in participant")
            //               return AnyView(EmptyView())
            //            case .attribution:
            //                print("in attribution")
            //                var learnerArr: [Learner?] = value.selected.map {getLearnerByID(id: $0)}
            //                if(learnerArr.count == 0){
            //                    print("learner nil")
            //                return AnyView(EmptyView())
            //                } else {
            //                    return  AnyView(Text("-\(learnerArr[0]!.name)"))
            //                }
            //            }
            return AnyView(EmptyView())
        case .documentValue(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .images(let value, let displayType, let createType, let editType):
            var width: CGFloat = 0
            switch displayType{
                
            case .smallScroll:
                width = UIScreen.main.bounds.width * 0.3
            case .mediumScroll:
                width = UIScreen.main.bounds.width * 0.4
            case .largeScroll:
                width = UIScreen.main.bounds.width * 0.7
            }
            return AnyView(GenericImagesView(images: value.map {$0.uiImage}, displayType: displayType, frameWidth: width))
        case .pdf(let value, let displayType, let createType, let editType):
            var width = UIScreen.main.bounds.width - 115
            return AnyView(
                PDFKitRepresentedView(pdfDoc: value.pdfDocument)
                    .frame(width: width, height: width * 1.29)
                // .padding(.top, -20)
            )
            
        case let .bool(value, displayType, createType, editType):
            switch displayType{
                
            case .ToDo:
                return  AnyView(
                    Image(systemName:
                        value ? "largecircle.fill.circle" : "circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                )
                
                
            }
            //            return AnyView(
            //                Text(value.description)
            //            )
        }
    }
}
