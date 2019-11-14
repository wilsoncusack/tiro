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
    
    init(_ element: Document_Element){
        self.id = element.id
        self.documentElement = element
        self.order = Int(element.order)
        self.value = shallowCopy(v: element.value!)
    }
    
    func updateCoreData(){
        documentElement.value = value
        // what if the document element type is a document
    }
    
    func createNewCoreData(document: Document){
//        print(self.value)
        var new = Document_Element(order: self.order, value: self.value, document: document)
    }
    
    func getEditView() -> AnyView{
        switch documentElement.value!{
        case .string(let value, let displayType, let editType):
            return  AnyView(
                VStack{
                    BasicText(str: value, onChange: {s in
//                        print("str in enum: \(s)")
                        //self.value
                        self.value = Value.string(value: s, displayType: displayType, editType: editType)
                        
                    })
                }
            )
        case .data(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .document(let value, let displayType, let editType):
            //load document
            //get transient
            // get edit view
            
            // no this is where the inline version goes
            // this need to have like an ontap that means you click in
            // get detail
            // get edit all over again 
            
            return AnyView(EmptyView())
        }
        
    
    }
}

/// hmm, need like sub dispaly types. if string -> these options
// point free is cool like that 

struct BasicText: View {
    @State var str: String
    var onChange: (String) -> Void
    @State var isFirstResponer = true
    // ^ shouldn't worry about having done in the nav bar, I think
    // unless we want to overwrite?
    // should just put a hide keyboard above
    var body: some View{
        VStack{
        UITextField(text: $str, onChange: onChange, isFirstResponder: $isFirstResponer)
            .frame(height: 300)
        }
    }
}

//struct NewPicker: View {
//    var
//}
