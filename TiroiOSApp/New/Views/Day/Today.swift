//
//  Today2.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/23/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


struct TemplatesHorizontalScroll: View {
    var onTap: (Document) -> Void
    
    @FetchRequest(
        entity: Document.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date, ascending: true)],
        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "is_template == true")
        ])
    )
    var templates: FetchedResults<Document>
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing: 20){
                ForEach(templates){t in
                    VStack{
                        Circle()
                            .foregroundColor(Color(UIColor.systemGray6)) //.foregroundColor(Color.secondary.opacity(0.1))
                            .frame(width: 60, height: 60)
                            
                            .overlay(
                                VStack{
                                    Image(systemName: t.system_image ?? "questionmark.circle")
                                        .foregroundColor(.primary)
                                }
                        )
                        //  Text(v.title)
                    }
                    .onTapGesture {
                        self.onTap(t)
                    }
                }
//                ForEach(ValueOptions.allCases){v in
//                    VStack{
//                        Circle()
//                            .foregroundColor(Color(UIColor.systemGray6)) //.foregroundColor(Color.secondary.opacity(0.1))
//                            .frame(width: 60, height: 60)
//
//                            .overlay(
//                                VStack{
//                                    Image(systemName: v.image)
//                                        .foregroundColor(.primary)
//                                }
//                        )
//                        //  Text(v.title)
//                    }.onTapGesture {
//                        self.onTap(v)
//                    }
//                }
            }.padding(.leading, 15)
                .padding(.trailing, 15)
        }
        .frame(height: 80)
        .padding(.top, 0)
    }
}



struct Today: View {
    @ObservedObject var store: Store<AppState, AppAction>
    @ObservedObject var today: Document
    @State var showValueModal = false
    @State var documentEditable: DocumentEditable? = nil
    @Environment(\.managedObjectContext) var managedObjectContext
    
//    var todayLoadable: {
//        DocumentLoadable(document: today)
//    }
    
    init(store: Store<AppState, AppAction>){
        self.store = store
        store.value.checkToday()
        today = store.value.today!
    }
    
    func templateTap(doc: Document) {
                let template = doc
            self.documentEditable = DocumentEditable(documentLoadable: DocumentLoadable(document: template))
                self.showValueModal = true
    
                self.today.objectWillChange.send()
    
                self.today.addToElements(
                    Document_Element(order: 0, value: Value.documentValue(value: DocumentValue(document: documentEditable!.documentLoadable.document), displayType: .basic, editType: .basic), type: .document, document: self.today)
                )
            }
    
//    func templateTap(v: ValueOptions) {
//            let template = v.template
//        self.documentEditable = DocumentEditable(documentLoadable: DocumentLoadable(document: template))
//            self.showValueModal = true
//
//            self.today.objectWillChange.send()
//
//            self.today.addToElements(
//                Document_Element(order: 0, value: Value.documentValue(value: DocumentValue(document: documentEditable!.documentLoadable.document), displayType: .basic, editType: .basic), type: .document, document: self.today)
//            )
//        }
    
    
    var body: some View{
        NavigationView{
            VStack{
                   TemplatesHorizontalScroll(onTap: self.templateTap)
                   
                   
                   
                   Divider()
                   
               
//                    
//                        Button(action: {
//                            createTemplates(creator: self.store.value.loggedInUser!)
//                        }) {
//                            Text("Make Template")
//                        }
                        
                                
                                TodayWrapper(today: DocumentLoadable(document: today))
                                
                           
                        Spacer()
                            
                        
                    }
       .sheet(isPresented: $showValueModal, onDismiss: {
        if(self.documentEditable!.documentLoadable.document.elements == nil
            || self.documentEditable!.documentLoadable.document.elements!.count == 0){
        self.today.objectWillChange.send()
            self.documentEditable!.cancel()
        }
        }){
        NavigationView{
            
//            self.transientDocument!
//                .createView
            
            DocumentEditableView(is_create: true, document: self.documentEditable!)
                //.getEditView()
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
            }
            
        
    }
}

struct TodayWrapper: View {
   // @ObservedObject var store: Store<AppState, AppAction>
    @ObservedObject var today: DocumentLoadable
   
   // @Environment(\.managedObjectContext) var managedObjectContext
    
    
    init(today: DocumentLoadable){
        // self.store = store
        self.today = today
        
       // self.today.loadAsync()
        

    }
    
    
    
    var body: some View{
       // NavigationView{
            
//                Button(action: {
//                    createTemplates(creator: self.store.value.loggedInUser!)
//                }) {
//                    Text("Make Template")
//                }
//                ScrollView{
//                    VStack(alignment: .leading){
                        
                        today.DetailView.frame(maxWidth: .infinity, maxHeight: .infinity)
//
//                    }
//                }
//                Spacer()
//                    .navigationBarTitle(Text(today.document.title), displayMode: .inline)
                
        //    }
//
            
        }
        
        
        
        
    }
}

//struct Today2_Previews: PreviewProvider {
//    static var previews: some View {
//        Today2()
//    }
//}
