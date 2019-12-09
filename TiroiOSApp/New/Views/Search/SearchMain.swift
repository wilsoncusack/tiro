//
//  SearchMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

// can improve performance by working with a persistent store manager
//

class SearchObject: ObservableObject {
    @Published var searchText = ""
    @Published var documents : [DocumentLoadable]
    @Published var searchMatches : [DocumentLoadable]
    var listener: AnyCancellable?
    
    init(documents: [DocumentLoadable]){
       // documents.map {$0.loadSync()}
        
        self.documents = documents
        self.searchMatches = documents
        
        self.listener = self.$searchText
//            .filter {
//                !$0.isEmpty
//        }
        .debounce(for: 0.5, scheduler: RunLoop.main)
    .removeDuplicates()
        .sink { (str) in
            if(!str.isEmpty){
            self.searchMatches = self.documents.filter {
            var tags = $0.document.tags?.allObjects as! [Tag]
            
            
                for t in tags {
                
                if (t.name.lowercased().contains(str.lowercased())){
                    return true
                }
            }
                
                
            return false
                }
            } else {
                self.searchMatches = self.documents
            }
            
        }
    }
    
    deinit{
        listener!.cancel()
    }
}
//
//struct SearchHerlper: View {
//    @ObservedObject var searchObj: SearchObject
//    var body: some View{
//
//    }
//}

struct SearchMain: View {
//    @FetchRequest(
//           entity: Document.entity(),
//           sortDescriptors: [NSSortDescriptor(keyPath: \Document.date, ascending: false)],
//           predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
//               NSPredicate(format: "type_private != 'day'"),
//            NSPredicate(format: "is_template = false")
//           ])
//       )
//       var documents: FetchedResults<Document>
     @ObservedObject var searchObj: SearchObject
    
//    var documentsLoadable: [DocumentLoadable]{
//        var toReturn = [DocumentLoadable]()
//        for d in documents {
//            let loadable = DocumentLoadable(document: d)
//            loadable.loadSync()
//            toReturn.append(loadable)
//        }
//        if(!searchText.isEmpty){
//            toReturn = toReturn.filter {
//                var tags = $0.document.tags?.allObjects as! [Tag]
//                for t in tags {
//                    if (t.name.lowercased().contains(searchText.lowercased())){
//                        return true
//                    }
//                }
//                return false
//            }
//        }
//        return toReturn
//    }
    var body: some View{
        NavigationView{
            
        ScrollView{
        VStack(alignment: .center){
            TextField("Search", text: $searchObj.searchText)
                .foregroundColor(.secondary)
                .padding(.all, 5)
                .frame(width: UIScreen.main.bounds.width - 30, height: 35, alignment: .center)
                .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
                .padding(.top, 10)
            
            
//                .frame(width: UIScreen.main.bounds - 30)
//                .cornerRadius(8)
        
            ForEach(searchObj.searchMatches, id: \.self.document.id){document in
                
                VStack{
                    DayRowView(document: document)
                //DocumentLoadableRowView(doc: document).frame(width: UIScreen.main.bounds.width)
                Divider()
                }
        }
        }
        }
        .navigationBarTitle("Search", displayMode: .inline)
        }
    }
}
