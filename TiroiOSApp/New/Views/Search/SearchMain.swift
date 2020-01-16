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
                    let searchText = str.lowercased()
                    self.searchMatches = self.documents.filter {
                        var tags = $0.document.tags?.allObjects as! [Tag]
                        
                        
                        for t in tags {
                            
                            if (t.name.lowercased().contains(searchText)){
                                return true
                            }
                        }
                        
                        if($0.document.title.lowercased() == searchText) {
                            return true
                        } else if(getDocumentTypeString(type: $0.document.type).lowercased() == searchText) {
                            return true
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
    @ObservedObject var searchObj: SearchObject
    
    var body: some View{
        NavigationView{
            
            ScrollView{
                VStack(alignment: .center){
                    TextField("Search", text: $searchObj.searchText)
                        .keyboardType(.webSearch)
                        .foregroundColor(.secondary)
                        .padding(.all, 5)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 35, alignment: .center)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(8)
                        .padding(.top, 10)
                    
                    
                    
                    ForEach(searchObj.searchMatches, id: \.self.document.id){document in
                        
                        VStack{
                            SearchRowView(document: document)
                            // .padding(.leading, 20)
                            //DocumentLoadableRowView(doc: document).frame(width: UIScreen.main.bounds.width)
                            //Divider()
                        }
                    }
                }//.padding(.top, 10)
                    .padding(.bottom, 20)
            }
//                 .background(Color(UIColor.systemGray6))
            .padding(.all, 0)
                
            .navigationBarTitle(Text("Search"), displayMode: .inline)
        }
    }
}
