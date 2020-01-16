//
//  DocumentLoadableRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct DocumentLoadableRowView: View {
    @ObservedObject var doc: DocumentLoadable
    var body: some View {
            
            switch doc.document.type {
            case .book:
                return AnyView(EmptyView())
            case .event:
                return AnyView(EmptyView())
            case .activity:
                return AnyView(ActivityRowView(documentLoadable: doc))
                
            case .day:
                return AnyView(
                RoundedRectangle(cornerRadius: 8)
                    
                    .stroke(Color.primary, lineWidth: 1)
                    .frame(width: 130, height: 100)
                    .overlay(
                        Text(doc.document.title)
                            .multilineTextAlignment(.center)
                            .frame(width: 110)
                    )
                    .padding(.all, 1)
                )
            case .text:
                return AnyView(TextRowView(document: doc))
            case .quote:
                
                let es: [ElementLoadable] = doc.elementWrappers
                    .compactMap {e -> ElementLoadable? in
                        switch e.element.type{
                            
                        
                        case .string, .picker:
                            return e
                        default:
                            return nil
                        }
                }
                return AnyView(
                    VStack(alignment: .leading){
                        ForEach(es, id: \.self.element.id){e in
                            ElementRowView(element: e)
                        }
                    }
                )
            case .image:
                return AnyView(
                    ImagesDocumentRowView(document: doc)
                )
            case .scan:
                let es: [ElementLoadable] = doc.elementWrappers
                    .compactMap {e -> ElementLoadable? in
                        switch e.element.type{
                        case .pdf:
                            return e
                        default:
                            return nil
                        }
                }
                return AnyView(
                    VStack(alignment: .leading){
                        ForEach(es, id: \.self.element.id){e in
                            ElementRowView(element: e)
                        }
                    }
                )
            case .video:
                return AnyView(EmptyView())
            case .question:
                let es: [ElementLoadable] = doc.elementWrappers
                    .compactMap {e -> ElementLoadable? in
                        switch e.element.type{
                        case .string:
                            return e
                        default:
                            return nil
                        }
                }
                if(es.count < 2){
                    return AnyView(EmptyView())
                } else {
                    var question = es[0]
                    var answer = es[1]
                return AnyView(
                    VStack(alignment: .leading){
                         ElementRowView(element: question)
//                        ForEach(es, id: \.self.element.id){e in
//                            ElementRowView(element: e)
//                        }
                    }
                )
                }
            case .activityReflection:
                return AnyView(EmptyView())
            case .camera:
                return AnyView(EmptyView())
            
        case .reading:
             let es: [ElementLoadable] = doc.elementWrappers
                .compactMap {e -> ElementLoadable? in
                    switch e.element.type{
                    case .string, .int:
                        return e
                    default:
                        return nil
                    }
            }
            return AnyView(
                VStack(alignment: .leading){
                    ForEach(es, id: \.self.element.id){e in
                        ElementRowView(element: e)
                    }
                }
            )
            case .toDo:
                var title: ElementLoadable
                var done: ElementLoadable
                let es: [ElementLoadable] = doc.elementWrappers
                    .compactMap {e -> ElementLoadable? in
                        switch e.element.type{
                        case .string, .bool:
                            return e
                        default:
                            return nil
                        }
                }
                if(es.count > 0){
                title = es[0]
                done = es[1]
                return AnyView(
                    ToDoRowView(title: title, done: done)
                )
                } else {
                    return AnyView(EmptyView())
                }
        }
            
        
    }
}

struct ToDoRowView: View{
    @ObservedObject var title: ElementLoadable
    @ObservedObject var done: ElementLoadable
    var body: some View{
        HStack(alignment: .center){
            ElementRowView(element: done)
                .onTapGesture {
                    if case let  .bool(value, display, create, edit) = self.done.value!{
                        var new = Value.bool(value: !value, displayType: display, createType: create, editType: edit)
                        self.done.objectWillChange.send()
                        self.done.element.updateValue(value: new)
                    }
                        
            }
            ElementRowView(element: title)
        }
    }
}

//struct DocumentLoadableRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentLoadableRowView()
//    }
//}
