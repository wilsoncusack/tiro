//
//  TodayMain.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/21/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct SaveToActivitiesLink: View {
    @ObservedObject var store: Store<ToDoState, ToDoAction>
    @ObservedObject var toDo: ToDo
    var tags: [Tag]{
        return toDo.tags?.allObjects as! [Tag]
    }
    
    var learners : [Learner]{
        if(toDo.learner != nil){
            return [toDo.learner!]
        }
        return []
    }
    
    var body: some View {
        HStack{
        Spacer()
            if(toDo.saved_to_activity){
                Text("Saved to activity")
                .bold()
                .foregroundColor(.green)
            }else {
         NavigationLink(destination:
                   ActivityEditableForm(
                       store:store.view(
                           value: {$0.activityState},
                           action: {.activity($0)}),
                       learnerSelectionManger: GenericSelectionManager(learners),
                       tagSelectionManager: GenericSelectionManager(tags),
                       title: toDo.title,
                       activityDate: toDo.due_date ?? Date(),
                       link: toDo.link ?? "",
                       notes: toDo.notes ?? "",
                       done: {
                           self.store.send(.editSavedToActivity(toDo: self.toDo, saved: true))
                   })){
                           
                    HStack{
                           Text("Save to Activity")
                               .foregroundColor(.primary)
                        Image(systemName: "chevron.right")
                        //.resizable()
                          //  .frame(width: 25, height: 25)
                    }
                               
               }
        }
            }//.frame(width: UIScreen.main.bounds.width).fixedSize()
    }
}

struct ToDoCard: View {
    @ObservedObject var store: Store<ToDoState, ToDoAction>
    @ObservedObject var toDo: ToDo
    
    
       
    
    var tags: [Tag]{
        return toDo.tags?.allObjects as! [Tag]
    }
    var tagsString : String {
        // var tags = toDo.tags?.allObjects as! [Tag]
        let names = tags.map {(tag: Tag) in tag.name}
        return names.joined(separator: ", ")
    }
    
    @State var dragOffset = CGSize.zero
    
    var body: some View{
        //        ZStack(alignment: .leading){
        //            Rectangle()
        
        
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(toDo.title)
                        .bold()
                    
                    
                    if(toDo.link != nil){
                        Link(toDo.link!)
                    }
                    HStack{
                        
                        if(toDo.learner != nil){
                            ProfileImage(learner: toDo.learner!, size: 30)
                                .shadow(radius: 20)
                        }
                        ForEach(tags){tag in
                            
                            Text(tag.name)
                            
                                
                                .padding(.top, 2)
                            .padding(.bottom, 2)
                            .padding(.leading, 3)
                            .padding(.trailing, 3)
                                .background(getColor(tag.name))
                            .cornerRadius(4)
                            
                        }
                    }
                }
                Spacer()
                if(toDo.done){
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        //.foregroundColor(.green)
                        .frame(width: 30, height: 30)
                }
            }
            if(toDo.done){
                Divider()
                SaveToActivitiesLink(store: store, toDo: toDo)
            } else {
                EmptyView()
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(toDo.done ? Color.green.opacity(0.05) : (Color.gray.opacity(0.2)))
//            .background((Color.gray.opacity(0.2)))
        .cornerRadius(8)
        .offset(x: dragOffset.width)
        .animation(.spring())
        .gesture(DragGesture()
            
        .onChanged {value in
            if(value.translation.width < 0 && value.translation.width > -300){
                self.dragOffset = value.translation
                
            }
        }
        .onEnded {value in
            if(value.translation.width < -200){
                //self.dragOffset = CGSize.zero
                
                /// need to send view store
                self.store.send(.editDone(toDo: self.toDo, done: !self.toDo.done))
               // self.toDo.done.toggle()
            }
            self.dragOffset = CGSize.zero
            }
        )
        
        //        }
    }
}

struct TodayMain: View {
    var store: Store<AppState, AppAction>
    
    @FetchRequest(
        entity: ToDo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.due_date!, ascending: true)],
        predicate: NSPredicate(format: "due_date >= %@", Date().removeTimeStamp() as NSDate))
    var toDos: FetchedResults<ToDo>
    @State var showModalDummy = false
    @State var modalContent: ToDoCreate?
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    func setModalContent(toDo: ToDo){
        self.modalContent = ToDoCreate(store: self.toDoStore,
        toDo: toDo,
        showModal: self.$showModalDummy)
        self.showModalDummy = true
    }
    
    
    var toDoStore: Store<ToDoState, ToDoAction> {
        self.store.view(
            value: {$0.toDoState},
            action: {.toDo($0)})
    }
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                
                VStack(alignment: .leading, spacing: 10){
                    Divider()
                    ForEach(toDos){toDo in
                        
                        Button(action: {
                            
                            self.setModalContent(toDo: toDo)
                        }){
                        ToDoCard(store: self.toDoStore, toDo: toDo)
                                            .padding(.leading, 15)
                    }.buttonStyle(PlainButtonStyle())
                                        
                        }
                    }
                    
                }
            
        .sheet(isPresented: $showModalDummy){
            self.modalContent.environment(\.managedObjectContext, self.managedObjectContext)
    }
            .navigationBarTitle("Today")
            .navigationBarItems(leading:
                Text(longDateFormatter.string(from: Date())).foregroundColor(.secondary))
        }
    }
}

//struct TodayMain_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayMain()
//    }
//}
