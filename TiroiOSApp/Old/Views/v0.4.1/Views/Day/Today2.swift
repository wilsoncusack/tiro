//
//  Today2.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/23/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//struct Today2: View {
//    @ObservedObject var store: Store<AppState, AppAction>
//    @State var documentEditable: DocumentEditable? = nil
//    @State var showValueModal = false
//    @State var modalContent: AnyView? = nil
//    @Environment(\.managedObjectContext) var managedObjectContext
//
//
//
//    @FetchRequest(
//        entity: Document.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
//        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
//            NSPredicate(format: "date_created >= %@", Date().removeTimeStamp() as NSDate),
//            NSPredicate(format: "type_private == %@", "day")
//        ])
//    )
//    var documents: FetchedResults<Document>
//
//
//    var today: DocumentLoadable {
//        if(documents.count != 0){
//            print("found today")
//            return DocumentLoadable(document: documents[0])
//
//        } else {
//            let today = makeDay(date: Date(), user: store.value.loggedInUser!)
//
//            return DocumentLoadable(document: today)
//        }
//
//    }
//
//
//
//    var body: some View {
//        NavigationView{
//            VStack{
//
//
//
//
//                Divider()
//                Button(action: {
//                    makePhotoPickerDocument(creator: self.store.value.loggedInUser!)
//                    makeTextTemplate(creator: self.store.value.loggedInUser!)
//                    makeQuoteTemplate(creator: self.store.value.loggedInUser!)
//                    makeScanTemplate(creator: self.store.value.loggedInUser!)
//                }) {
//                    Text("Make Template")
//                }
//               // TodayWrapper(today: today)
//                Spacer()
//                    .navigationBarTitle(Text(today.document.title), displayMode: .inline)
//
//            }.sheet(isPresented: $showValueModal, onDismiss: {
//                self.today.objectWillChange.send()
//                self.documentEditable!.cancel()
////                if(self.tDoc!.document.elements!.count == 0){
////                    print("we here")
////                    self.tDoc!.cancel()
////                }
//
//
//            }){
//                NavigationView{
//
//                    DocumentEditableView(document: self.documentEditable!)
//                       // .createView
//                        //.getEditView()
//                        .environment(\.managedObjectContext, self.managedObjectContext)
//                } //self.modalContent!//.environmentObject(self.today)
//
//            }
//
//        }
//
//
//    }
//}

struct TemplatesHorizontalScroll: View {
    var onTap: (ValueOptions) -> Void
    
    @FetchRequest(
        entity: Document.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "is_template == true")
        ])
    )
    var templates: FetchedResults<Document>
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing: 20){
                ForEach(ValueOptions.allCases){v in
                    VStack{
                        Circle()
                            .foregroundColor(Color(UIColor.systemGray6)) //.foregroundColor(Color.secondary.opacity(0.1))
                            .frame(width: 60, height: 60)
                            
                            .overlay(
                                VStack{
                                    Image(systemName: v.image)
                                        .foregroundColor(.primary)
                                }
                        )
                        //  Text(v.title)
                    }.onTapGesture {
                        self.onTap(v)
                    }
                }
            }.padding(.leading, 15)
                .padding(.trailing, 15)
        }
        .frame(height: 80)
        .padding(.top, 0)
    }
}

func createTemplates(creator: User){
    makePhotoPickerDocument(creator: creator)
    makeTextTemplate(creator: creator)
    makeQuoteTemplate(creator: creator)
    makeScanTemplate(creator: creator)
    AppDelegate.shared.saveContext()
}

struct TodayTest: View {
    @ObservedObject var store: Store<AppState, AppAction>
    @ObservedObject var today: Document
    @State var showValueModal = false
    @State var documentEditable: DocumentEditable? = nil
    @Environment(\.managedObjectContext) var managedObjectContext
    
//    var todayLoadable: {
//        DocumentLoadable(document: today)
//    }
    
    func templateTap(v: ValueOptions) {
            let template = v.template
        self.documentEditable = DocumentEditable(documentLoadable: DocumentLoadable(document: template))
           // let transient = template.getEditableVersion(user: self.store.value.loggedInUser!)
           // self.transientDocument = transient
            self.showValueModal = true
            
            self.today.objectWillChange.send()
    //        self.today.document.objectWillChange.send()
            self.today.addToElements(
                Document_Element(order: 0, value: Value.documentValue(value: DocumentValue(document: documentEditable!.documentLoadable.document), displayType: .basic, editType: .basic), type: .document, document: self.today)
            )
        }
    
    
    var body: some View{
        NavigationView{
            VStack{
                   TemplatesHorizontalScroll(onTap: self.templateTap)
                   
                   
                   
                   Divider()
                   
               
                    
                        Button(action: {
                            createTemplates(creator: self.store.value.loggedInUser!)
                        }) {
                            Text("Make Template")
                        }
                        
                                
                                TodayWrapper(today: DocumentLoadable(document: today))
                                
                           
                        Spacer()
                            .navigationBarTitle(Text(today.title), displayMode: .inline)
                        
                    }
       .sheet(isPresented: $showValueModal, onDismiss: {
        self.today.objectWillChange.send()
            self.documentEditable!.cancel()
        }){
        NavigationView{
            
//            self.transientDocument!
//                .createView
            DocumentEditableView(document: self.documentEditable!)
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
                ScrollView{
                    VStack(alignment: .leading){
                        
                        today.DetailView.frame(maxWidth: .infinity, maxHeight: .infinity)
//
                    }
                }
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
