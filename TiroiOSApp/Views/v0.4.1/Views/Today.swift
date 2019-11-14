//
//  Today.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/5/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData


struct ValueModal: View{
    var body: some View{
        List(ValueOptions.allCases){v in
            HStack{
                Image(systemName: v.image)
                    //.resizable()
                    .frame(width: 20, height: 20)
                
                Text(v.title)
                
            }
        }
    }
}

var orangeMedium = Color(red: 0.9921568627, green: 0.9490196078, blue: 0.8274509804)

func getTemplate(name: String, type: DocumentType) -> Document {
    let templateFetch = NSFetchRequest<Document>(entityName: "Document")
    let p1 = NSPredicate(format: "is_template == true")
    let p2 = NSPredicate(format: "type_private == %@", type.rawValue)
    templateFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1, p2])
    do {
        let fetchedTemplates = try AppDelegate.viewContext.fetch(templateFetch)
        return fetchedTemplates[0]
    } catch {
        fatalError("Failed to fetch users: \(error)")
    }
}

struct Today: View {
    @ObservedObject var store: Store<AppState, AppAction>
    @State var sheet1 = false
    @State var showValueModal = false
    @State var modalContent: AnyView? = nil
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
    var today: Document {
        if(documents.count != 0){
                    return documents[0]
            
        } else {
            let today = Document(title: longDateFormatter.string(from: Date()), type: .day, elements: nil, tags: nil, associated_users: nil, created_by: store.value.loggedInUser!, date: nil)
            AppDelegate.shared.saveContext()
            return today
        }
       
    }
    
    var todayTransient: TransientDocument {
        today.getEditableVersion(user: store.value.loggedInUser!)
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("templates: \(templates.count)")
                VStack(alignment: .leading, spacing: 0){
                    ScrollView(.horizontal, showsIndicators: false){
                        
                        HStack(spacing: 20){
                            ForEach(ValueOptions.allCases){v in
                                VStack{
                                    Circle()
                                        .foregroundColor(Color.secondary.opacity(0.1))
                                        .frame(width: 60, height: 60)
                                        
                                        .overlay(
                                            VStack{
                                                Image(systemName: v.image)
                                                    .foregroundColor(.primary)
                                            }
                                    )
                                    //  Text(v.title)
                                }.onTapGesture {
                                    var template = v.template
                                    var transient = template.getEditableVersion(user: self.store.value.loggedInUser!)
                                    self.today.addToElements(
                                        Document_Element(order: 0, value:
                                            Value.document(value: transient.document.id.description, displayType: .basic, editType: .basic), document: self.today))
                                    self.modalContent = transient.getEditView()
                                    // need to save the selected document
                                    // so that it can be deleted on dismiss 
                                    self.showValueModal = true
                                }
                            }
                        }
                    }
                    .frame(height: 80)
                    .padding(.top, 0)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    
                    
                }
                Divider()
                ScrollView{
                    
                    VStack{
                        Text("elements: \(today.elements?.count ?? 0)")
                        today.getDetailView()

                        EmptyView()
                    }
                }.sheet(isPresented: $showValueModal){
                    NavigationView{
                    self.modalContent!//.environmentObject(self.today)
                    }
                }
                    
                    
                .navigationBarTitle(Text(today.title), displayMode: .inline)

            }
        }
    }
}

//struct Today_Previews: PreviewProvider {
//    static var previews: some View {
//        Today()
//    }
//}
