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
    
    init(documentLoadable: DocumentLoadable){
        if(documentLoadable.document.is_template){
            self.is_template = true
            let d = copyTemplate(document: documentLoadable.document)
            self.documentLoadable = DocumentLoadable(document: d)
        } else {
            self.documentLoadable = documentLoadable
        }
        self.editableElements = []
        for e in documentLoadable.elementWrappers {
            self.editableElements.append(DocumentElementEditable(elementLoadable: e))
        }
    }
    
    func save(){
        documentLoadable.objectWillChange.send()
        if(is_template){
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
        AppDelegate.shared.saveContext()
    }
    
    func cancel(){
        if(is_template){
            AppDelegate.shared.persistentContainer.viewContext.delete(self.documentLoadable.document)
        }
    }
}

func elementToDocumentSavePropgation(document: Document, elementValue: Value){
    switch elementValue{
    case let .picker(value, _, _):
        if(value.isCoreData){
            switch value.coreDataType!{
            case .learner:
                let learners = value.selected.map {getLearnerByID(id: $0)}
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
    return Document(title: document.title, type: document.type, elements: nil, tags: document.tags, associated_users: document.associated_users, created_by: document.created_by, date: Date())
}


struct DocumentEditableView: View {
    var document: DocumentEditable
    @Environment(\.presentationMode) var presentationMode
    
    func save(){
        self.document.save()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func cancel(){
        self.document.cancel()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View{
        VStack{
            Form{
            ForEach(document.editableElements, id: \.self.elementLoadable.element.id){editableElement in
                EditableElementView(element: editableElement)
                
            }
            }
        }
        .navigationBarItems(leading:
            Button(action: {self.cancel()}){
                Text("Cancel").foregroundColor(.red)
            }
            
            , trailing:
            Button(action: {self.save()}){
                Text("Save")
            }
        )
        
    }
}



class ObservableValue<AValue>: ObservableObject {
    @Published var value: AValue
    var listner: AnyCancellable?
    
    init(value: AValue, save: @escaping (AValue) -> Void){
        self.value = value
        self.listner = self.$value.sink(receiveValue: { (value) in
            save(value)
        })
    }
    
    deinit{
        self.listner?.cancel()
    }
}


