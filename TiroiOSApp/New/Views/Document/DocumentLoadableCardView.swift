//
//  DocumentLoadableCardView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/11/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct DocumentLoadableCardView: View {
    @ObservedObject var docLoadable: DocumentLoadable
    var body: some View {
        switch docLoadable.document.type {
            
        case .book:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .event:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .activity:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .day:
            return AnyView( Text(docLoadable.document.title)
                                       .multilineTextAlignment(.center)
                .frame(width: 110, height: 100))
        case .text:
            let es: [ElementLoadable] = docLoadable.elementWrappers
                .compactMap {e -> ElementLoadable? in
                    switch e.element.type{
                        
                    
                    case .string:
                        return e
                    default:
                        return nil
                    }
            }
            var text: ElementLoadable? = nil
            if(es.count > 0){
                text = es[0]
            }
            return AnyView(
                VStack(alignment: .leading){
                    if(text != nil){
                    ElementRowView(element: text!)
                    }
//                    Text(hourAndMinute.string(from: docLoadable.document.date))
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                    Text(longDateFormatter.string(from: docLoadable.document.date))
//                    .font(.caption)
//                    .foregroundColor(.secondary)
                }.frame(width: 150, height: 100)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.secondary, lineWidth: 0.8)
//                    .frame(width: 154, height: 104)
//                )
//                    .padding(.all, 3)
            )
        case .quote:
            let es: [ElementLoadable] = docLoadable.elementWrappers
                .compactMap {e -> ElementLoadable? in
                    switch e.element.type{
                        
                    
                    case .string, .picker:
                        return e
                    default:
                        return nil
                    }
            }
            var text: ElementLoadable? = nil
            var person: ElementLoadable? = nil
            if(es.count > 0){
                text = es[0]
                person = es[1]
            }
            return AnyView(
                VStack(alignment: .leading){
                    if(text != nil){
                    ElementRowView(element: text!)
                    ElementDetailView(element: person!)
                        .padding(.leading, -20)
                    }
//                    Text(hourAndMinute.string(from: docLoadable.document.date))
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                    Text(longDateFormatter.string(from: docLoadable.document.date))
//                    .font(.caption)
//                    .foregroundColor(.secondary)
                }.frame(width: 150, height: 100))
        case .image:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .camera:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .scan:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .video:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .question:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .activityReflection:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .reading:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        case .toDo:
            return AnyView(DocumentLoadableRowView(doc: docLoadable))
        }
    }
}

//struct DocumentLoadableCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentLoadableCardView()
//    }
//}
