//
//  TextRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/29/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

func getFirstElementOfType(elements: [ElementLoadable], type: ElementValueType, load: Bool) -> ElementLoadable? {
    for e in elements{
        if case type = e.element.type {
            if(load){
                e.loadSync()
            }
                return e
        }
        
    }
    return nil
}

struct TextRowView: View {
    @ObservedObject var document: DocumentLoadable
    
    var text: ElementLoadable? {
        getFirstElementOfType(elements: document.elementWrappers, type: .string, load: true)
    }
   
    
    var body: some View {
        Group{
        if(text == nil){
             EmptyView()
        } else {
         ElementRowView(element: text!)
            
        }
        }
    }
}

//struct TextRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextRowView()
//    }
//}
