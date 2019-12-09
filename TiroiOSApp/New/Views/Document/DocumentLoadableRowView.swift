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
                return AnyView(EmptyView())
            case .day:
                return AnyView(EmptyView())
            case .text:
                return AnyView(TextRowView(document: doc))
            case .quote:
                
                let es: [ElementLoadable] = doc.elementWrappers
                    .compactMap {e -> ElementLoadable? in
                        switch e.element.type{
                            
                        
                        case .string:
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
                return AnyView(EmptyView())
            case .reflection:
                return AnyView(EmptyView())
            case .camera:
                return AnyView(EmptyView())
            }
            
        
    }
}

//struct DocumentLoadableRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentLoadableRowView()
//    }
//}
