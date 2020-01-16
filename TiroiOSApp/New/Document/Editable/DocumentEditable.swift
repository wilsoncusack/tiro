//
//  DocumentEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class DocumentEditable {
    var documentLoadable: DocumentLoadable
    var editableElements: [DocumentElementEditable]
    var is_template = false
    var dummyDate: Date? = nil
    
    init(documentLoadable: DocumentLoadable){
        if(documentLoadable.document.is_template){
            self.is_template = true
            let d = copyTemplate(document: documentLoadable.document)
             AppDelegate.shared.saveContext()
            self.documentLoadable = DocumentLoadable(document: d)
        } else {
            self.documentLoadable = documentLoadable
        }
        self.editableElements = []
        for e in documentLoadable.elementWrappers {
            let editable = DocumentElementEditable(documentEditable: self, elementLoadable: e)
            self.editableElements.append(editable)
        }
    }
    
    func save(){
      //  DispatchQueue.main.async{
        self.documentLoadable.document.objectWillChange.send()
            self.documentLoadable.objectWillChange.send()
            if(self.is_template){
            for e in self.editableElements{
                e.createNewCoreData(document: self.documentLoadable.document)
                elementToDocumentSavePropgation(document: self.documentLoadable.document, elementValue: e.localValue)
            }
        } else {
            for e in self.editableElements{
                e.updateCoreData()
                elementToDocumentSavePropgation(document: self.documentLoadable.document, elementValue: e.localValue)
            }
        }
        if(dummyDate != nil){
            self.documentLoadable.document.date = dummyDate!
        }
        AppDelegate.shared.saveContext()
        //}
    }
    
    func cancel(){
        for e in editableElements{
            e.localValue = e.elementLoadable.value!
        }
        
        if(is_template){
            AppDelegate.shared.persistentContainer.viewContext.delete(self.documentLoadable.document)
            AppDelegate.shared.saveContext()
        }
    }
    
    func getEditView() -> DocumentEditableView{
        DocumentEditableView(is_create: false, document: self)
    }
    
    var editView: DocumentEditableView{
        DocumentEditableView(is_create: false, document: self)
    }
}

func elementToDocumentSavePropgation(document: Document, elementValue: Value){
    switch elementValue{
    case let .picker(value, _, _):
        if(value.isCoreData){
            switch value.coreDataType!{
            case .user:
                let learners = value.selected.map {getUserByID(id: $0)}
                document.associated_users = NSSet(array: learners as [Any])
            case .tag:
                let tags = value.selected.map {getTagByID(id: $0)}
                
                document.tags = NSSet(array: tags as [Any])
                
            }
            
        }
    default:
        do {
        }
        
    }
}

func copyTemplate(document: Document) -> Document {
    let d = Document(title: document.title, type: document.type, elements: nil, tags: document.tags, associated_users: document.associated_users, created_by: document.created_by, date: Date())
    d.system_image = document.system_image
    return d
}


struct DocumentEditableView: View {
    var is_create: Bool
    var document: DocumentEditable
    @Environment(\.presentationMode) var presentationMode
    @State var savePressed = false
    
    func save(){
        
        self.presentationMode.wrappedValue.dismiss()
        self.document.save()
    }
    
    func cancel(){
        self.document.cancel()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View{
        ScrollView{
        VStack{
            
            Form{
            ForEach(document.editableElements, id: \.self.elementLoadable.element.id){editableElement in
                EditableElementView(element: editableElement, is_create: self.is_create)
                
            }
                
            }
            Spacer()
        }
        
        .frame(minHeight: UIScreen.main.bounds.height)
        .navigationBarTitle(Text(document.documentLoadable.document.title), displayMode: .inline)
        .navigationBarItems(leading:
            Button(action: {self.cancel()}){
                Text("Cancel").foregroundColor(.red)
            }
            
            , trailing:
            Button(action: {
                if(!self.savePressed){
                self.save()
                }
                
            }){
                Text("Save")
            }
        )
        }
        
    }
}






