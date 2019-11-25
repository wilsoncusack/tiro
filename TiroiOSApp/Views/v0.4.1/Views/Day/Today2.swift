//
//  Today2.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/23/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct Today2: View {
    @ObservedObject var store: Store<AppState, AppAction>
    @State var tDoc: TransientDocument? = nil
    @State var showValueModal = false
    @State var modalContent: AnyView? = nil
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Document.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
        NSPredicate(format: "date_created >= %@", Date().removeTimeStamp() as NSDate),
            NSPredicate(format: "type_private == %@", "day")
        ])
    )
    var documents: FetchedResults<Document>
    
    @FetchRequest(
        entity: Document.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
        NSPredicate(format: "is_template == true")
        ])
    )
    var templates: FetchedResults<Document>
    var today: DocumentWrapper2 {
        if(documents.count != 0){
            print("found today")
                    return DocumentWrapper2(document: documents[0])
            
        } else {
            let today = makeDay(date: Date(), user: store.value.loggedInUser!)
            
            return DocumentWrapper2(document: today)
        }
       
    }
    
//    init(store: Store<AppState, AppAction>){
//        self.store = store
//        self.today.load()
//    }
    
    
    var body: some View {
        NavigationView{
            VStack{
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
                                           let template = v.template
                                           let transient = template.getEditableVersion(user: self.store.value.loggedInUser!)
                                           self.tDoc = transient
                                          // self.modalContent = transient.getEditView()
                                           self.showValueModal = true
                                           
                                           self.today.objectWillChange.send()
                                        self.today.document.addToElements(
                                               Document_Element(order: 0, value:
                                                   Value.documentWrapper(
                                                       value: DocumentWrapper(document: transient.document),
                                                       displayType: .basic, editType: .basic), document: self.today.document))
                                       }
                                   }
                               }
                           }
                           .frame(height: 80)
                           .padding(.top, 0)
                           .padding(.leading, 15)
        .padding(.trailing, 15)
        
        Divider()
//                Button(action: {
//                                            makePhotoPickerDocument(creator: self.store.value.loggedInUser!)
//                                            makeTextTemplate(creator: self.store.value.loggedInUser!)
//                                        }) {
//                                            Text("Make Template")
//                                        }
        TodayWrapper(today: today)
            Spacer()
        .navigationBarTitle(Text(today.document.title), displayMode: .inline)
                
            }.sheet(isPresented: $showValueModal, onDismiss: {
                                self.today.objectWillChange.send()
                                if(self.tDoc!.document.elements!.count == 0){
                                print("we here")
                                    self.tDoc!.cancel()
                                }
                                
                                
                            }){
                                NavigationView{
                                    
                                    self.tDoc!
                                    .createView
                                        //.getEditView()
                                        .environment(\.managedObjectContext, self.managedObjectContext)
                                    } //self.modalContent!//.environmentObject(self.today)
                                
                            }
        
    }
            
        
    }
}

struct TodayWrapper: View {
    @ObservedObject var today: DocumentWrapper2
    
    init(today: DocumentWrapper2){
        self.today = today
        self.today.load()
    }
    
    var body: some View{
        
            ScrollView{
                VStack(alignment: .leading){
                    
            AnyView(today.DetailView.frame(maxWidth: .infinity, maxHeight: .infinity))
        
                }
            }
            
        
    }
}

//struct Today2_Previews: PreviewProvider {
//    static var previews: some View {
//        Today2()
//    }
//}
