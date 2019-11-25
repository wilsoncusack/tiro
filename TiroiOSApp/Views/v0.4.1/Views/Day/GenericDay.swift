//
//  BasicDay.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct GenericDay: View {
    @ObservedObject var document: Document
    //@State var documents: [Document]  = []
   
    
    var documents: [Document]{
        let es = document.elements?.allObjects as! [Document_Element]
        var toReturn =  [Document]()
            for e in es{
                if case .documentWrapper(let value, let displayType, let editType) = e.value {
                    toReturn.append(value.document)

//                let d : Document? = getDocumentFromElement(e: e)
//                if(d != nil){
//                    toReturn.append(d!)
            }
        }
        toReturn.sort(by: {a, b in
            if(a.date >= b.date){
                return false
            } else {
                return true
            }
        })
        return toReturn


    }
        
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            ForEach(documents){d in
                BasicDayRow(document: d)
            }
        }
        .padding(.leading, 15)
    }
    
}

struct GenericDay2: View {
    @ObservedObject var document: DocumentWrapper2
    //@State var documents: [Document]  = []
   
    
    var documents: [DocumentWrapper2]{
        //let es = document.elements?.allObjects as! [Document_Element]
        var toReturn =  [DocumentWrapper2]()
        for e in document.elementWrappers{
          //  e.load()
            if case .documentWrapper(let value, let displayType, let editType) = e.element.value {
                    var toAdd = DocumentWrapper2(document: value.document)
                    toAdd.load()
                // ^ is this the best place? 
                    toReturn.append(toAdd)

//                let d : Document? = getDocumentFromElement(e: e)
//                if(d != nil){
//                    toReturn.append(d!)
            }
        }
        toReturn.sort(by: {a, b in
            if(a.document.date >= b.document.date){
                return false
            } else {
                return true
            }
        })
        return toReturn


    }
        
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            ForEach(documents, id: \.document.id){d in
                BasicDayRow2(document: d)
               // BasicDayRow(document: d)
            }
        }
        .padding(.leading, 15)
    }
    
}
