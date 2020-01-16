//
//  DayView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct DayView: View {
     @ObservedObject var document: DocumentLoadable
       var documents: [DocumentLoadable]{
           var toReturn =  [DocumentLoadable]()
           for e in document.elementWrappers{
               if case .document =  e.element.type {
                   e.loadSync()
                   if case .documentValue(let value, let displayType, let editType) = e.value{
                    var toAdd = DocumentLoadable(document: value.document, element: e.element)
                       //toAdd.loadAsync()
                       toReturn.append(toAdd)
                   }
               }
           }
           toReturn.sort(by: {a, b in
               if(a.document.date < b.document.date){
                   return false
               } else {
                   return true
               }
           })
           return toReturn


       }
           
       
       var body: some View{
         ScrollView{
           VStack(alignment: .leading, spacing: 20){
               ForEach(documents, id: \.document.id){d in
                DayRowView(document: d)
               }
               Spacer()
           }
           .padding(.leading, 15)
        }
         .navigationBarTitle(Text(document.document.title), displayMode: .inline)
       }
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView()
//    }
//}
