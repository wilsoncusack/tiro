//
//  getDayView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

//extension Document{
//
//
//
//    var dayView: some View{
//        switch self.type{
//        case .book:
//            return AnyView(EmptyView())
//        case .event:
//            return AnyView(EmptyView())
//        case .activity:
//            return AnyView(EmptyView())
//        case .day:
//            return AnyView(EmptyView())
//        case .text:
////            var elements = self.elements?.allObjects as! [Document_Element]
//            return AnyView(TextViewDay(document: self))
//        case .quote:
//            return AnyView(EmptyView())
//        case .image:
//            return AnyView(NewImageDayView(document: self))
//        //AnyView(ImageDayView(document: self))
//        case .scan:
//            return AnyView(EmptyView())
//        case .video:
//            return AnyView(EmptyView())
//        case .question:
//            return AnyView(EmptyView())
//        case .reflection:
//            return AnyView(EmptyView())
//        case .camera:
//            return AnyView(EmptyView())
//        }
//    }
//}
//
//func getImages(elements: [Document_Element]) -> [UIImage]{
//     var toReturn = [UIImage]()
//            for e in elements {
//                if case .dataArray(let value, let displayType, let createType, let editType) = e.value! {
//                switch displayType{
//
//                case .images:
//    //                for d in value{
//    //                    toReturn.append(getImageFromData(data: d))
//    //                }
//                    return value.map {getImageFromData(data: $0)}
//
//
//                }
//            }
//        }
//            return toReturn
//}

//struct NewImageDayView: View {
//   @ObservedObject var document: Document
//    //@State var images = [UIImage]()
//
//   // @State var caption = ""
//    
//    var elements: [Document_Element]{
//         return self.document.elements?.allObjects as! [Document_Element]
//    }
//    
//    var images: [UIImage]{
//        var toReturn = [UIImage]()
//                               for e in elements {
//                                   if case .images(let value, let displayType, let createType, let editType) = e.value! {
//                                   switch displayType{
//                   
//                                   case .images:
//                                       toReturn  = value.map {$0.uiImage}
//                   
//                   
//                                   }
//                                   }
//                           }
//                   //self.images =
//        return toReturn
//    }
//    
//    var caption: String{
//        for e in elements {
//            if case .string(let value, let displayType, let editType) = e.value! {
//                   return value
//            }
//        }
//        return ""
//    }
//    
//
//    var body: some View{
//        VStack(alignment: .leading, spacing: 0){
//            
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack(spacing: 10){
//                    ForEach(self.images, id: \.self){
//                        Image(uiImage: $0)
//                        .resizable()
//                            .aspectRatio(contentMode: .fit)
//                        .frame(width: UIScreen.main.bounds.width - 115)
//                        
//                           // .frame(width: 400)
//                       // .scaledToFit()
//                    }
//                }
//            }
//            if(!caption.isEmpty){
//                HStack(spacing: 0){
//                Text(caption)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .padding(.all, 5)
//                    .padding(.leading, 0)
//                    Spacer()
//                }
//                   // .background(Color(UIColor.systemGray6))
//            }
//            }
////        .onAppear(){
////            var elements = self.document.elements?.allObjects as! [Document_Element]
////                        for e in elements {
////                            if case .images(let value, let displayType, let createType, let editType) = e.value! {
////                            switch displayType{
////
////                            case .images:
////                                self.images = value.map {$0.uiImage}
////
////
////                            }
////                            }
////                            if case .string(let value, let displayType, let editType) = e.value! {
////                                self.caption = value
////                        }
////                    }
////            //self.images = toReturn
////        }
//    }
//}
//
//struct ImageDayView: View {
//    @ObservedObject var document: Document
//    
//    var elements: [Document_Element]{
//        document.elements?.allObjects as! [Document_Element]
//    }
//    
//    var images: [UIImage] {
//        var toReturn = [UIImage]()
//        for e in elements {
//            if case .dataArray(let value, let displayType, let createType, let editType) = e.value! {
//            switch displayType{
//                
//            case .images:
////                for d in value{
////                    toReturn.append(getImageFromData(data: d))
////                }
//                return value.map {getImageFromData(data: $0)}
//                   
//                
//            }
//        }
//    }
//        return toReturn
//    }
//    
//    var image: some View {
//            //var toReturn = [UIImage]()
//            for e in elements {
//                if case .dataArray(let value, let displayType, let createType, let editType) = e.value! {
//                    return AnyView(e.displayView)
//            }
//        }
//          //  return toReturn
//        return AnyView(EmptyView())
//        }
//    
////    var value: Value {
////        for e in elements {
////                    if case .dataArray(let value, let displayType, let createType, let editType) = e.value! {
////
////
////                }
////    }
//    
//    var body: some View{
//        VStack{
//        ScrollView(.horizontal, showsIndicators: false){
//          
//              
//        HStack(spacing: 10){
//           // Text("images length: \(images.count)")
//           // Text("type: \(images[0].)")
//            //Text("Images 0 \{")
//            image
////            ForEach(getImages(elements: elements), id: \.self){image in
////                Image(uiImage: image).resizable().scaledToFit()
////        }
//                }.frame(height: 200)
//            }
//    }
//}
//}
