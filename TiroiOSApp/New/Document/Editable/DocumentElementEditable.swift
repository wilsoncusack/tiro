//
//  DocumentElementEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

class DocumentElementEditable {
    var elementLoadable: ElementLoadable
    var localValue: Value
    
    init(elementLoadable: ElementLoadable){
        self.elementLoadable = elementLoadable
        if(elementLoadable.value == nil){
            elementLoadable.loadSync()
        }
        self.localValue = elementLoadable.value!
        //self.localValue = shallowCopy(v: elementLoadable.value!)
    }
    
    func updateLocaValue(v: Value){
        self.localValue = v
    }
    
    func updateCoreData(){
        elementLoadable.element.updateValue(value: localValue)
        //watch for specific keys?
    }
    
    func createNewCoreData(document: Document){
        var new = Document_Element(
            order: Int(self.elementLoadable.element.order),
            value: localValue,
            type: self.elementLoadable.element.type,
            document: document)
        new.objectWillChange.send()
    }
    
    
}




