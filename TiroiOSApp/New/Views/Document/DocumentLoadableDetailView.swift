//
//  DocumentDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct DocumentLoadableDetailView: View {
    @ObservedObject var doc: DocumentLoadable
    
    func getEdit() -> DocumentEditableView {
        DocumentEditableView(is_create: false, document: DocumentEditable(documentLoadable: doc))
    }
    
    var body: some View {
        ScrollView(.vertical){
            
            VStack(alignment: .leading){
                ForEach(doc.elementWrappers, id: \.self.element.id){element in
                    ElementDetailView(element: element)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity)
                }
                Spacer()
                    .navigationBarItems(trailing:
                        NavigationLink(destination:
                            self.doc.editable)
                        {
                            Text("Edit")
                        }.buttonStyle(PlainButtonStyle())
                )
            }.padding(.top, 20)
             
        }
        
        
    }
}

//struct DocumentLoadableDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentDetailView()
//    }
//}
