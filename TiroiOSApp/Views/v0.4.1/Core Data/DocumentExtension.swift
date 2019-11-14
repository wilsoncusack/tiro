//
//  DocumentExtension.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

extension Document{
    
    func getCardView() -> AnyView {
        switch self.type{
        case .book:
            return AnyView(EmptyView())
        case .event:
            return AnyView(EmptyView())
        case .activity:
            return AnyView(EmptyView())
        case .day:
            return AnyView(EmptyView())
        case .text:
            return AnyView(EmptyView())
        case .quote:
            return AnyView(EmptyView())
        case .image:
            return AnyView(EmptyView())
        case .scan:
            return AnyView(EmptyView())
        case .video:
            return AnyView(EmptyView())
        case .question:
            return AnyView(EmptyView())
        case .reflection:
            return AnyView(EmptyView())
        }
    }
    
    func getDayView() -> AnyView{
        switch self.type{
        case .book:
            return AnyView(EmptyView())
        case .event:
            return AnyView(EmptyView())
        case .activity:
            return AnyView(EmptyView())
        case .day:
            return AnyView(EmptyView())
        case .text:
//            var elements = self.elements?.allObjects as! [Document_Element]
            return AnyView(TextViewDay(document: self))
        case .quote:
            return AnyView(EmptyView())
        case .image:
            return AnyView(EmptyView())
        case .scan:
            return AnyView(EmptyView())
        case .video:
            return AnyView(EmptyView())
        case .question:
            return AnyView(EmptyView())
        case .reflection:
            return AnyView(EmptyView())
        }
    }
    
    func getDetailView() -> AnyView {
        let elements = self.elements?.allObjects as! [Document_Element]
        switch self.type{
        case .book:
            return AnyView(EmptyView())
        case .event:
            return AnyView(EmptyView())
        case .activity:
            return AnyView(EmptyView())
        case .day:
            print("in day")
           return AnyView(
                ForEach(elements){element in
                    getDayView2(e: element)
                }
            )
        case .text:
            return AnyView(
                //NavigationView{
               BasicDisplay(doc: self)
                //}
            )
        case .quote:
            return AnyView(EmptyView())
        case .image:
            return AnyView(EmptyView())
        case .scan:
            return AnyView(EmptyView())
        case .video:
            return AnyView(EmptyView())
        case .question:
            return AnyView(EmptyView())
        case .reflection:
            return AnyView(EmptyView())
        }
    }
    
    func getEditableVersion(user: User) -> TransientDocument {
        let transient = TransientDocument(self, loggedInUser: user)
        return transient
    }
}

struct BasicDisplay: View {
    @ObservedObject var doc: Document
    
    var elements: [Document_Element]{
        doc.elements?.allObjects as! [Document_Element]
    }
    
    var body: some View{
        ForEach(elements){element in
            element.getDisplayView()
                       }
                       .navigationBarItems(trailing:
                        NavigationLink(destination: self.doc.getEditableVersion(user: self.doc.created_by).getEditView()){
                               Text("Edit")
                           }
                           )
    }
    
}

func getDayView2(e: Document_Element) -> AnyView {
    switch e.value{
    case let .document(value: docId, displayType: displayType, editType: editType):
        print("in document")
        var document = getDocument(id: docId)
        if(document != nil){
            return AnyView(NavigationLink(destination: document!.getDetailView()){
                document!.getDayView()
            })
        } else {
           return AnyView(EmptyView())
        }
       
    default:
        return AnyView(EmptyView())
    }
   
}

func getDocument(id: String) -> Document? {
    let fetch = NSFetchRequest<Document>(entityName: "Document")
    let p2 = NSPredicate(format: "id == %@", id)
    fetch.predicate = p2
    do {
        let fetched = try AppDelegate.viewContext.fetch(fetch)
        if(fetched.count > 0){
            print("found")
        return fetched[0]
        } else {
            print("couldn't find document")
            return nil
            
        }
    } catch {
        fatalError("Failed to fetch users: \(error)")
    }
}

struct TextViewDay: View {
    @ObservedObject var document: Document
    var elements :  [Document_Element] {
        return document.elements?.allObjects as! [Document_Element]
    }
    
    // this feels wrong
    func getText(element: Document_Element) -> String? {
        switch element.value!{
        
        case .string(let value, let displayType, let editType):
            return value
        default:
            return nil
        }
    }
    
    
    var text: String {
        var texts = elements.map {getText(element: $0)}.filter {$0 != nil}
        if(texts.count > 0){
        return texts[0]!
        } else {
            return "Couldn't find"
        }
    }
    
    var body: some View{
        VStack{
            Text("elements: \(elements.count)")
        Text(text)
        }
    }
}
