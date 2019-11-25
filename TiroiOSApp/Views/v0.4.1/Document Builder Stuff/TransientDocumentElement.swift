//
//  TransientDocumentElement.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

class TransientDocumentElement: ObservableObject, Identifiable{
    let id: UUID
    let documentElement: Document_Element
    @Published var order: Int
    @Published var value: Value
    var originalValue: Value
    
    init(_ element: Document_Element){
        self.id = element.id
        self.documentElement = element
        self.order = Int(element.order)
        var v = shallowCopy(v: element.value!)
        self.value = v
        self.originalValue = v
    }
    
    func updateCoreData(){
        print("in updarte core data")
        documentElement.objectWillChange.send()
        documentElement.value = value
        if case .picker(let value, let display, let edit) = self.value {
            if(value.isCoreData){
            switch value.coreDataType!{
            case .learner:
            let learners = value.selected.map {getLearnerByID(id: $0)}
            self.documentElement.document.associated_users = NSSet(array: learners)
            case .tag:
                let tags = value.selected.map {getTagByID(id: $0)}
               
               self.documentElement.document.tags = NSSet(array: tags)
                
                }
                
            }
        }
    }
    
    func cancelEdit(){
        documentElement.objectWillChange.send()
        documentElement.value = originalValue
    }
    
    func createNewCoreData(document: Document){
//        print(self.value)
        var new = Document_Element(order: self.order, value: self.value, document: document)
        new.objectWillChange.send()
        if  case .dataArray(let value, let displayType, let createType, let editType) = self.value {
            print("saving data array")
        }
         if case .picker(let value, let display, let edit) = self.value {
             if(value.isCoreData){
             switch value.coreDataType!{
             case .learner:
             let learners = value.selected.map {getLearnerByID(id: $0)}
             document.associated_users = NSSet(array: learners)
             case .tag:
                 let tags = value.selected.map {getTagByID(id: $0)}
                
                document.tags = NSSet(array: tags)
                 
                 }
                 
             }
         }
    }
    
    
}


