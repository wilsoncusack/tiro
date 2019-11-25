//
//  GenericDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct GenericDetailView: View {
    @ObservedObject var doc: Document
    
    var elements: [Document_Element]{
        var elements = doc.elements?.allObjects as! [Document_Element]
        elements.sort(by: {a, b in
               if(a.order >= b.order){
                   return false
               } else {
                   return true
               }
           })
        return elements
        
    }
    
   
    
    var body: some View{
        ScrollView(.vertical){
            
        VStack(alignment: .leading){
//            Text("elements: \(elements.count)")
        ForEach(elements){element in
            NewGenericDisplayView(element: ElementWrapper(element: element), widthOffset: 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            element.displayView
                       }
            Spacer()
                       .navigationBarItems(trailing:
                        NavigationLink(destination: self.doc.getEditableVersion(user: self.doc.created_by).getEditView()){
                               Text("Edit")
                        }.buttonStyle(PlainButtonStyle())
                           )
        }
        }
    }
    
}

struct GenericDetailView2: View {
    @ObservedObject var doc: DocumentWrapper2
    
//    var elements: [Document_Element]{
//        var elements = doc.elements?.allObjects as! [Document_Element]
//        elements.sort(by: {a, b in
//               if(a.order >= b.order){
//                   return false
//               } else {
//                   return true
//               }
//           })
//        return elements
//
//    }
    
   
    
    var body: some View{
        ScrollView(.vertical){
            
        VStack(alignment: .leading){
//            Text("elements: \(elements.count)")
            ForEach(doc.elementWrappers, id: \.self.element.id){element in
              //  element.D
            NewGenericDisplayView(element: element, widthOffset: 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            element.displayView
                       }
            Spacer()
                       .navigationBarItems(trailing:
                        NavigationLink(destination: self.doc.document.getEditableVersion(user: self.doc.document.created_by).getEditView()){
                               Text("Edit")
                        }.buttonStyle(PlainButtonStyle())
                           )
        }
        }
    }
    
}


