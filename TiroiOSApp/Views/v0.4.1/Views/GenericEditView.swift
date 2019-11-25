//
//  GenericEditView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct GenericEditView: View {
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
            Form{
                ForEach(elements){element in
                    element.editView
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
       // }
    }
}


