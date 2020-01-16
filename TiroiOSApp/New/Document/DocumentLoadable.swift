//
//  DocumentLoadable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

class DocumentLoadable: Identifiable, ObservableObject{
    var id: UUID
    var document: Document
    var element: Document_Element? = nil
    @Published var elementWrappers: [ElementLoadable]
    
    init(document: Document){
        self.id = document.id
        self.document = document
        var elements = self.document.elements?.allObjects as! [Document_Element]
        elements.sort(by: sortElementsByOrder)
        self.elementWrappers = []
        for element in elements{
            self.elementWrappers.append(ElementLoadable(element: element))
        }
        //self.element = element
    }
    
    init(document: Document, element: Document_Element){
        self.id = document.id
        self.document = document
        var elements = self.document.elements?.allObjects as! [Document_Element]
        elements.sort(by: sortElementsByOrder)
        self.elementWrappers = []
        for element in elements{
            self.elementWrappers.append(ElementLoadable(element: element))
        }
        self.element = element
    }
    
//    func loadAsync(){
//        DispatchQueue.main.async {
//            var elements = self.document.elements?.allObjects as! [Document_Element]
//            elements.sort(by: sortElementsByOrder)
//            for element in elements{
//                self.elementWrappers.append(ElementLoadable(element: element))
//            }
//        }
//    }
//    
//    func loadSync(){
//        var elements = self.document.elements?.allObjects as! [Document_Element]
//        elements.sort(by: sortElementsByOrder)
//        for element in elements{
//            self.elementWrappers.append(ElementLoadable(element: element))
//        }
//        
//    }
    
    
    
    var DetailView: AnyView{
        switch self.document.type{
        case .day:
            return AnyView(DayView(document: self))
        default:
            return AnyView(DocumentLoadableDetailView(doc: self))
        }
    }
    
    func getEditable() -> DocumentEditableView {
        DocumentEditable(documentLoadable: self).getEditView()
        //AnyView(DocumentEditableView(is_create: false, document: DocumentEditable(documentLoadable: self)))
    }
    
    var editable: DocumentEditableView{
        DocumentEditable(documentLoadable: self).editView
        //.getEditView()
//        AnyView(DocumentEditableView(is_create: false, document: DocumentEditable(documentLoadable: self)))
//        TransientDocument(self, loggedInUser: self.document.created_by).getEditView()
    }
    
//    func delete(){
//        if(self.element != nil){
//            self.element!.objectWillChange.send()
//            AppDelegate.shared.persistentContainer.viewContext.delete(self.element!)
//        }
//        self.document.objectWillChange.send()
//        AppDelegate.shared.persistentContainer.viewContext.delete(self.document)
//        AppDelegate.shared.saveContext()
//    }
}

func sortElementsByOrder(_ a: Document_Element, _ b: Document_Element) -> Bool {
    if(a.order >= b.order){
        return false
    } else {
        return true
    }
}
