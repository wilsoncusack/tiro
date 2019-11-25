//
//  TransientDocument.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

class TransientDocument: ObservableObject {
    let loggedInUser: User
    @Published var document: Document
    var is_create = false
    @Published var title: String
    let type: DocumentType
    @Published var tags: [Tag]
    @Published var users: [Learner]
    @Published var date: Date
    @Published var elements: [TransientDocumentElement]
    
    init(_ document: Document, loggedInUser: User){
        
        
        self.loggedInUser = loggedInUser
        self.title = document.title
        self.type = document.type
        self.tags = document.tags?.allObjects as! [Tag]
        self.users = document.associated_users?.allObjects as! [Learner]
        self.date = document.date
        let originalElements = document.elements?.allObjects as! [Document_Element]
        self.elements = originalElements.map {TransientDocumentElement($0)}
        if(document.is_template){
            is_create = true
            self.document = Document(title: document.title, type: document.type, elements: nil, tags: document.tags, associated_users: document.associated_users, created_by: loggedInUser, date: nil)
            AppDelegate.shared.saveContext()
        } else {
            self.document = document
        }
    }
    
    func saveNew(creator: User){
        if(self.is_create){
            print("is create")
            document.objectWillChange.send()
            for e in elements{
                e.createNewCoreData(document: self.document)
            }
        } else {
            document.objectWillChange.send()
            updateCoreData()
        }
        
        AppDelegate.shared.saveContext()
    }
    
    func cancel(){
        // need to know if it's a
        // create. Delete if it's a create
        if(self.is_create){
            
            document.objectWillChange.send()
            AppDelegate.shared.persistentContainer.viewContext.delete(self.document)
        }
//        else {
//            for e in elements{
//                e.cancelEdit()
//            }
//        }
       
    }
    
    private func updateCoreData(){
        for e in elements{
            
            e.updateCoreData()
        }
    }
    
    func getEditView() -> AnyView {
        return AnyView(GenericEditView(tDoc: self))
        
    }
    
    var createView: GenericCreateView{
        return GenericCreateView(tDoc: self)
    }
}

struct GenericCreateView: View{
    @ObservedObject var tDoc: TransientDocument
       @Environment(\.presentationMode) var presentationMode
    var elements: [TransientDocumentElement]{
        var elements = tDoc.elements
        elements.sort(by: {a, b in
               if(a.order >= b.order){
                   return false
               } else {
                   return true
               }
           })
        return elements
        
    }
    
    
    var body: some View {
        // if it is model, we need this
        // just wrap the modal then
        //NavigationView{
        VStack(alignment: .leading){
            Form{
                ForEach(elements){element in
                    element.createView
                    //element.getEditView()
                }
            }
            .navigationBarTitle(Text(tDoc.title), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action:
                {
                    self.tDoc.cancel()
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){Text("Cancel")}
                ,trailing: Button(action:
            {
                self.tDoc.saveNew(creator: self.tDoc.loggedInUser)
                self.presentationMode.wrappedValue.dismiss()
                
            }){Text("Save")})
            Spacer()
        }
       // }
    }
}



func shallowCopy(v: Value) -> Value{
    switch v{
        
    case .string(let value, let displayType, let editType):
        return Value.string(value: value, displayType: displayType, editType: editType)
    case .data(let value, let displayType, let editType):
        return Value.data(value: value, displayType: displayType, editType: editType)
    case .int(let value, let displayType, let editType):
        return Value.int(value: value, displayType: displayType, editType: editType)
    case .date(let value, let displayType, let editType):
        return Value.date(value: value, displayType: displayType, editType: editType)
    case .picker(let value, let displayType, let editType):
        return Value.picker(value: value, displayType: displayType, editType: editType)
//    case .document(let value, let displayType, let editType):
//        return Value.document(value: value, displayType: displayType, editType: editType)
    case .dataArray(let value, let displayType, let createType, let editType):
        return Value.dataArray(value: value, displayType: displayType, createType: createType, editType: editType)
    case .documentWrapper(let value, let displayType, let editType):
        return Value.documentWrapper(value: value, displayType: displayType, editType: editType)
    case .images(let value, let displayType, let createType, let editType):
        return Value.images(value: value, displayType: displayType, createType: createType, editType: editType)
    }
}
