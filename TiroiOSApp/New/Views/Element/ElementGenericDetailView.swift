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
                ElementDetailViewLoaded(element: element.element ,value: element.value!, documentType: element.element.document.type)
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
        case .bool:
            return AnyView(EmptyView())
        }
    }
}

struct ElementDetailViewLoaded: View {
    @ObservedObject var element: Document_Element
    var value: Value
    var documentType: DocumentType
    
    var body: some View{
        switch value{
            
        case .string(let value, let displayType, _):
            switch displayType{
                
            case .text:
                return AnyView(
                    VStack(alignment: .leading){
                        if(documentType == .question){
                            Text("Answer")
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                        }
                        HStack{
                            Text(value.string)
                                
                                .font(.body)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                )
                
            case .caption:
                return AnyView(
                    HStack{
                        Text(value.string)
                            .font(.subheadline)
                            //                            .foregroundColor(.secondary)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        Spacer()
                })
            case .quote:
                return AnyView(
                    VStack(alignment: .leading){
                        if(documentType == .question){
                            Text("Question")
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                        }
                        HStack{
                            Text(value.string)
                                
                                .font(.body)
                                .italic()
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                    
                )
            case .bookTitle:
                return AnyView(
                    HStack(spacing: 4){
                        Text("Read")
                        Text(value.string)
                            .fontWeight(.semibold)
                            .italic()
                        
                        Spacer()
                    }.padding(.leading, 20)
                )
            case .title:
                return AnyView(
                    HStack{
                        
                        Text(value.string)
                            .fontWeight(.bold)
                       // lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }.padding(.leading, 20)
                )
                
            }
            
            
        case .int(let value, let displayType, let editType):
            switch displayType{
                
            case .dollars:
                return AnyView(EmptyView())
            case .minutes:
                return AnyView(
                    HStack{
                        if(value == -1){
                            EmptyView()
                        } else {
                        Text("for \(value.description) minutes")
                            //  .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        }
                    }.padding(.leading, 20)
                )
                
            }
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return AnyView(
                PickerDetailView(picker: value, displayMode: .detail, displayType: displayType)
                    .padding(.leading, 20)
                    .padding(.top, 10)
                // .padding(.bottom, 5)
            )
        case .documentValue(let value, let displayType, let editType):
            return AnyView(
                DocumentLoadableDetailView(doc: DocumentLoadable(document: value.document))
            )
        case .images(let value, let displayType, let createType, let editType):
            var width: CGFloat = 0
            var leadingPadding: CGFloat = 0
            switch displayType{
                
            case .smallScroll:
                leadingPadding = 20
                width = UIScreen.main.bounds.width * 0.6
            case .mediumScroll:
                leadingPadding = 20
                width = UIScreen.main.bounds.width * 0.7
            case .largeScroll:
                width = UIScreen.main.bounds.width 
            }
            return AnyView(GenericImagesView(images: value.map {$0.uiImage}, displayType: displayType, frameWidth: width).padding(.top, documentType == .image ? -20 : 0).padding(.leading, leadingPadding))
        case .pdf(let value, let displayType, let createType, let editType):
            
            return AnyView(
                PDFKitRepresentedView(pdfDoc: value.pdfDocument)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.29)
                    .padding(.top, -20)
            )
        case let .bool(value, displayType, createType, editType):
            return AnyView(
                HStack(alignment: .center){
                    // VStack(alignment: .leading, spacing: 5){
                    Text(value ? "Done" : "Not Done")
                        //   .italic()
                        .padding(.all, 0)
                        //.foregroundColor(.secondary)
                        
                        .foregroundColor(value ? .green : .orange)
                    Text("-")
                    // .foregroundColor(.secondary)
                    Button(action: {
                        //  self.
                        self.element.updateValue(value: Value.bool(value: !value, displayType: displayType, createType: createType, editType: editType))
                    }){
                        Text(value ? "Mark Undone" : "Mark Done")
                    }
                    //}
                    Spacer()
                }.frame(height: 25).padding(.leading, 20)
            )
        }
    }
}

