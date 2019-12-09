//
//  DocumentLoadable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

class DocumentLoadable: ObservableObject{
    var document: Document
    @Published var elementWrappers: [ElementLoadable]
    
    init(document: Document){
        self.document = document
        var elements = self.document.elements?.allObjects as! [Document_Element]
        elements.sort(by: sortElementsByOrder)
        self.elementWrappers = []
        for element in elements{
            self.elementWrappers.append(ElementLoadable(element: element))
        }
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
    
    var editable: AnyView{
        AnyView(DocumentEditableView(document: DocumentEditable(documentLoadable: self)))
//        TransientDocument(self, loggedInUser: self.document.created_by).getEditView()
    }
}

func sortElementsByOrder(_ a: Document_Element, _ b: Document_Element) -> Bool {
    if(a.order >= b.order){
        return false
    } else {
        return true
    }
}
