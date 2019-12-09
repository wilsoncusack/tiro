////
////  Today.swift
////  TiroiOSApp
////
////  Created by Wilson Cusack on 11/5/19.
////  Copyright © 2019 Wilson Cusack. All rights reserved.
////
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

//struct TodayHolder: View {
//     @ObservedObject var store: Store<AppState, AppAction>
//    @State var loading = true
//
////    @FetchRequest(
////        entity: Document.entity(),
////        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
////        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
////        NSPredicate(format: "date_created >= %@", Date().removeTimeStamp() as NSDate),
////            NSPredicate(format: "type_private == %@", "day")
////        ])
////    )
////    var documents: FetchedResults<Document>
////
////    var today: Document {
////        if(documents.count != 0){
////                    return documents[0]
////
////        } else {
////            let today = makeDay(date: Date(), user: store.value.loggedInUser!)
////
////            return today
////        }
////
////    }
//
//
////    var today : Today{
////        Today(store: store)
////    }
//    var body: some View{
//        //TodayTest(today: today)
//        Group{
//            if(loading){
//                Text("loading")
//            } else{
//                Today(store: store, loading: $loading)
//
//            }
//        }.onAppear(){
//            self.loading = false
//        }
//        .onDisappear(){
//            self.loading = true
//        }
//    }
//}
//
//struct Today: View {
//    @ObservedObject var store: Store<AppState, AppAction>
//    @Binding var loading: Bool
//    @State var tDoc: TransientDocument? = nil
//    @State var showValueModal = false
//    @State var modalContent: AnyView? = nil
//    @Environment(\.managedObjectContext) var managedObjectContext
//
//    @FetchRequest(
//        entity: Document.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
//        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
//        NSPredicate(format: "date_created >= %@", Date().removeTimeStamp() as NSDate),
//            NSPredicate(format: "type_private == %@", "day")
//        ])
//    )
//    var documents: FetchedResults<Document>
//
//    @FetchRequest(
//        entity: Document.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \Document.date_created, ascending: true)],
//        predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
//        NSPredicate(format: "is_template == true")
//        ])
//    )
//    var templates: FetchedResults<Document>
//    var today: Document {
//        if(documents.count != 0){
//                    return documents[0]
//
//        } else {
//            let today = makeDay(date: Date(), user: store.value.loggedInUser!)
//
//            return today
//        }
//
//    }
//
//    var todayTransient: TransientDocument {
//        today.getEditableVersion(user: store.value.loggedInUser!)
//    }
//
//
//    var body: some View {
//        NavigationView{
//            VStack{
//               // Text("templates: \(templates.count)")
//                VStack(alignment: .leading, spacing: 0){
//                    ScrollView(.horizontal, showsIndicators: false){
//
//                        HStack(spacing: 20){
//                            ForEach(ValueOptions.allCases){v in
//                                VStack{
//                                    Circle()
//                                        .foregroundColor(Color(UIColor.systemGray6)) //.foregroundColor(Color.secondary.opacity(0.1))
//                                        .frame(width: 60, height: 60)
//
//                                        .overlay(
//                                            VStack{
//                                                Image(systemName: v.image)
//                                                    .foregroundColor(.primary)
//                                            }
//                                    )
//                                    //  Text(v.title)
//                                }.onTapGesture {
//                                    let template = v.template
//                                    let transient = template.getEditableVersion(user: self.store.value.loggedInUser!)
//                                    self.tDoc = transient
//                                   // self.modalContent = transient.getEditView()
//                                    self.showValueModal = true
//
//                                    self.today.objectWillChange.send()
//                                    self.today.addToElements(
//                                        Document_Element(order: 0, value:
//                                            Value.documentWrapper(
//                                                value: DocumentWrapper(document: transient.document),
//                                                displayType: .basic, editType: .basic), type: .document,document: self.today))
//                                }
//                            }
//                        }
//                    }
//                    .frame(height: 80)
//                    .padding(.top, 0)
//                    .padding(.leading, 15)
//                    .padding(.trailing, 15)
//
//
//                }
//                Divider()
//                ScrollView{
//
//                    VStack{
//                        //Text("elements: \(today.elements?.count ?? 0)")
//                       // today.getDetailView()
////                        Button(action: {
////                            makePhotoPickerDocument(creator: self.store.value.loggedInUser!)
////                            makeTextTemplate(creator: self.store.value.loggedInUser!)
////                        }) {
////                            Text("Make Template")
////                        }
//                        TodayTest(today: today)
//
//                       // EmptyView()
//                    }
//                }.sheet(isPresented: $showValueModal, onDismiss: {
//                    // check if it's not changed
//                    // delete it?
////                    self.today.objectWillChange.send()
//
//                    self.today.objectWillChange.send()
//                    if(self.tDoc!.document.elements!.count == 0){
////                    AppDelegate.shared.persistentContainer.viewContext.delete(self.tDoc!.document)
//                    print("we here")
//                        self.tDoc!.cancel()
//                    }
//
//
//                }){
//                    NavigationView{
//
//                        self.tDoc!
//                        .createView
//                            //.getEditView()
//                            .environment(\.managedObjectContext, self.managedObjectContext)
//                        } //self.modalContent!//.environmentObject(self.today)
//
//                }
//
//            .navigationBarItems(leading: EmptyView(), trailing: EmptyView())
//                .navigationBarTitle(Text(today.title), displayMode: .inline)
//                .onAppear(){
//                    self.loading = false
//                }
//            }
//        }
//    }
//}
//
////struct Test1: View {
////    @ObservedObject var tDoc: TransientDocument
////    var body: some View{
////        Group{
////        if(tDoc!.elements[0].value.count > 0){
////            Image(uiImage: UIImage(data: tDoc.elements[0].$value)!)
////        } else {
////            Text("Nothing")
////        }
////        }
////    }
////}
//
//struct TodayTest: View{
//    @ObservedObject var today: Document
//
//    var elements: [Document_Element]{
//        var elements = today.elements?.allObjects as! [Document_Element]
//        elements.sort(by: {a, b in
//               if(a.order >= b.order){
//                   return false
//               } else {
//                   return true
//               }
//           })
//        return elements
//
//    }
//
//    var body: some View{
//        today.detailView
////        VStack{
////            ForEach(elements){element in
////                 NewValueTest(obj: NewValueTestObj(documentElement: element))
////            }
////
////        }
//    }
//}
//
////struct Today_Previews: PreviewProvider {
////    static var previews: some View {
////        Today()
////    }
////}
