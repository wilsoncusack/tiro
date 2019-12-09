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

//extension Document{
//    
//    // this really need to be
//    // in document wrapper 2
//    func getEditableVersion(user: User) -> TransientDocument {
//        let transient = TransientDocument(DocumentLoadable(document: self), loggedInUser: user)
//        return transient
//    }
//}





//struct BasicDisplay: View {
//    @ObservedObject var doc: Document
//
//    var elements: [Document_Element]{
//        doc.elements?.allObjects as! [Document_Element]
//    }
//
//    var body: some View{
//        ForEach(elements){element in
//            element.getDisplayView()
//                       }
//                       .navigationBarItems(trailing:
//                        NavigationLink(destination: self.doc.getEditableVersion(user: self.doc.created_by).getEditView()){
//                               Text("Edit")
//                           }
//                           )
//    }
//
//}

//func getDocumentFromElement(e: Document_Element) -> Document? {
//    switch e.value{
//    case let .document(value: docId, displayType: displayType, editType: editType):
//        print("in document")
//        let document = getDocumentFromID(id: docId)
//        if(document != nil){
//            return document
//                //AnyView(NavigationLink(destination: document!.getDetailView()){
//              //  document!.getDayView()
//            } else {
//           return nil //AnyView(EmptyView())
//        }
//
//    default:
//        return nil //AnyView(EmptyView())
//    }
//
//}

func getDocumentFromID(id: String) -> Document? {
    let fetch = NSFetchRequest<Document>(entityName: "Document")
    let p2 = NSPredicate(format: "id == %@", id)
    fetch.predicate = p2
    do {
        let fetched = try AppDelegate.viewContext.fetch(fetch)
        if(fetched.count > 0){
            print("found document")
        return fetched[0]
        } else {
            print("couldn't find document")
            return nil
            
        }
    } catch {
        fatalError("Failed to fetch users: \(error)")
    }
}



let hourAndMinute: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.dateStyle = .short
    formatter.setLocalizedDateFormatFromTemplate("mmhh")
    return formatter
}()
