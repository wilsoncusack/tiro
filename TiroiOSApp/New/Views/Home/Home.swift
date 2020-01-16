//
//  Home.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/9/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct Home: View {
    @ObservedObject var store: Store<AppState, AppAction>
    
    @FetchRequest(
           entity: Document.entity(),
           sortDescriptors: [NSSortDescriptor(keyPath: \Document.date, ascending: false)],
           predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
               NSPredicate(format: "is_template = false")
           ])
       )
    var documents: FetchedResults<Document>
    
    var seperatedDocuments: [[Document]]{
        var docDict = [DocumentType: [Document]]()
        for d in documents {
            var arr: [Document] = docDict[d.type] ?? []
            arr.append(d)
            docDict[d.type] = arr
        }
        var toReturn = [[Document]]()
        for k in docDict.keys{
            toReturn.append(docDict[k]!)
        }
        toReturn.sort { (a, b) -> Bool in
            if(a[0].type == .day){
                return true
            } else if(b[0].type == .day){
                return false
            } else {
            return a[0].title < b[0].title
            }
        }
        return toReturn
    }
    
    
    var body: some View {
        NavigationView{
        
            ScrollView{
                VStack(alignment: .leading){
            ForEach(seperatedDocuments, id: \.self){docArr in
                VStack(alignment: .leading){
                    Text(getDocumentTypeString(type: docArr[0].type))
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                    ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                ForEach(docArr){doc in
                    GenericCardView(documentLoadable: DocumentLoadable(document: doc))
                    Divider()
                        }
                        //.rotationEffect(Angle.init(degrees: 90))
                    }.padding(.bottom, 20)
                    
                }
                }.padding(.leading, 20)
            }//.padding()
                }.padding(.top, 10)
        }
        .navigationBarTitle("Home", displayMode: .inline)
        //.navigationBarHidden(true)
    }
    }
}

struct GenericCardView: View {
    @ObservedObject var documentLoadable: DocumentLoadable
    
    var body: some View{
        
        NavigationLink(destination: documentLoadable.DetailView){
            VStack(alignment: .leading){
                DocumentLoadableCardView(docLoadable: documentLoadable)
                    .padding(.bottom, 5)
                if(documentLoadable.document.type != .day){
                Text(hourAndMinute.string(from: documentLoadable.document.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(longDateFormatter.string(from: documentLoadable.document.date))
                .font(.caption)
                    .foregroundColor(.secondary)
                }
            }.frame(minWidth: 150)
        //DocumentLoadableCardView(docLoadable: documentLoadable)
        }.buttonStyle(PlainButtonStyle())
        
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
