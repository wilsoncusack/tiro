//
//  TransientDocument.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

//class TransientDocument: ObservableObject {
//    let loggedInUser: User
//    @Published var document: Document
//    @Published var wrapped: DocumentLoadable
//    var is_create = false
//    @Published var title: String
//   // let type: DocumentType
//    @Published var tags: [Tag]
//    @Published var users: [Learner]
//    @Published var date: Date
//    @Published var elements: [TransientDocumentElement]
//    
//    init(_ document: DocumentLoadable, loggedInUser: User){
//        
//        if(document.elementWrappers.isEmpty){
//           // document.loadSync()
//        }
//        self.wrapped = document
//        self.loggedInUser = loggedInUser
//        self.title = document.document.title
//        //self.type = document.document.type
//        self.tags = document.document.tags?.allObjects as! [Tag]
//        self.users = document.document.associated_users?.allObjects as! [Learner]
//        self.date = document.document.date
//        let originalElements = document.elementWrappers
//        self.elements = originalElements.map {TransientDocumentElement($0)}
////        for e in elements{
////            if (e.type == .picker){
////                e.$value.receive(on: <#T##Scheduler#>)
////            }
////        }
//         print("type: \(document.document.type)")
//        if(document.document.is_template){
//           
//            is_create = true
//            self.document = Document(title: document.document.title, type: document.document.type, elements: nil, tags: document.document.tags, associated_users: document.document.associated_users, created_by: loggedInUser, date: nil)
//            AppDelegate.shared.saveContext()
//        } else {
//            self.document = document.document
//        }
//    }
//    
//    func saveNew(creator: User){
//        DispatchQueue.main.async {
//            
//        if(self.is_create){
////            print("is create")
////            self.wrapped.objectWillChange.send()
//            for e in self.elements{
//                e.createNewCoreData(document: self.document)
//            }
//        } else {
//            //self.document.objectWillChange.send()
//            self.updateCoreData()
//        }
//        
//        AppDelegate.shared.saveContext()
//        }
//    }
//    
//    func cancel(){
//        // need to know if it's a
//        // create. Delete if it's a create
//        if(self.is_create){
//            
//            document.objectWillChange.send()
//            AppDelegate.shared.persistentContainer.viewContext.delete(self.document)
//        }
////        else {
////            for e in elements{
////                e.cancelEdit()
////            }
////        }
//       
//    }
//    
//    private func updateCoreData(){
//        wrapped.objectWillChange.send()
//       // document.objectWillChange.send()
//        for e in elements{
//            
//            e.updateCoreData()
//        }
//        
//        //AppDelegate.shared.saveContext()
//        
////        wrapped.loadSync()
//    }
//    
//    func getEditView() -> AnyView {
//        return AnyView(GenericEditView(tDoc: self))
//        
//    }
//    
//    var createView: GenericCreateView{
//        return GenericCreateView(tDoc: self)
//    }
//}

//struct GenericCreateView: View{
//    @ObservedObject var tDoc: TransientDocument
//       @Environment(\.presentationMode) var presentationMode
//    var elements: [TransientDocumentElement]{
//        var elements = tDoc.elements
//        elements.sort(by: {a, b in
//               if(a.order >= b.order){
//                   return false
//               } else {
//                   return true
//               }
//           })
//        return elements
//
//    }
//
//
//    var body: some View {
//        // if it is model, we need this
//        // just wrap the modal then
//        //NavigationView{
//        VStack(alignment: .leading){
//            Form{
//                ForEach(elements){element in
//                    element.createView
//                    //element.getEditView()
//                }
//            }
//            .navigationBarTitle(Text(tDoc.title), displayMode: .inline)
//            .navigationBarItems(leading:
//                Button(action:
//                {
//                    self.tDoc.cancel()
//                    self.presentationMode.wrappedValue.dismiss()
//
//                }){Text("Cancel")}
//                ,trailing: Button(action:
//            {
//                self.tDoc.saveNew(creator: self.tDoc.loggedInUser)
//                self.presentationMode.wrappedValue.dismiss()
//
//            }){Text("Save")})
//            Spacer()
//        }
//       // }
//    }
//}



func shallowCopy(v: Value) -> Value{
    switch v{
        
    case .string(let value, let displayType, let editType):
        return Value.string(value: value, displayType: displayType, editType: editType)
    case .int(let value, let displayType, let editType):
        return Value.int(value: value, displayType: displayType, editType: editType)
    case .date(let value, let displayType, let editType):
        return Value.date(value: value, displayType: displayType, editType: editType)
    case .picker(let value, let displayType, let editType):
        return Value.picker(value: value, displayType: displayType, editType: editType)
    case .documentValue(let value, let displayType, let editType):
        return Value.documentValue(value: value, displayType: displayType, editType: editType)
    case .images(let value, let displayType, let createType, let editType):
        return Value.images(value: value, displayType: displayType, createType: createType, editType: editType)
    case .pdf(let value, let displayType, let createType, let editType):
        return Value.pdf(value: value, displayType: displayType, createType: createType, editType: editType)
    
    case .bool(let value, let displayType, let createType, let editType):
        return Value.bool(value: value, displayType: displayType, createType: createType, editType: editType)
    }
}
