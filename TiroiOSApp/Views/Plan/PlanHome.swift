//
//  PlanHome.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

// hmm, should activities have a planned slider
// or should plans be a different thing altogether 

import SwiftUI

struct Link: View {
    var link: String
    init(_ link: String){
        self.link = link
    }
    var body: some View{
        Text(link).onTapGesture {
            if let url = URL(string: self.link) {
                UIApplication.shared.open(url)
            }
        }.lineLimit(1).foregroundColor(.blue)
    }
}

// create to do
// on finish, create an activity, and ask to take a picture
// I think once I have this I can start charging, so let's go
var orangeBright = Color(red: 0.9529411765, green: 0.8392156863, blue: 0.4705882353)
var orangeSoft = Color(red: 255, green: 0.9843137255, blue: 0.9411764706)

let toDoDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.dateStyle = .short
    formatter.setLocalizedDateFormatFromTemplate("EEE dd/MM/YY")
    return formatter
}()

struct SaveToActivityLink: View {
    @ObservedObject var store: Store<ToDoState, ToDoAction>
    @ObservedObject var toDo: ToDo
    
    var learners : [Learner]{
        if(toDo.learner != nil){
            return [toDo.learner!]
        }
        return []
    }
    
    var tags: [Tag]{
        return toDo.tags?.allObjects as! [Tag]
    }
    
    //    var activity: Activity {
    //
    //        // we have to delete this if they change their mind
    //        ActivityEditableForm(store:store.view(
    //        value: {$0.activityState},
    //            action: {.activity($0)}), learnerSelectionManger: GenericSelectionManager(learners), tagSelectionManager: GenericSelectionManager(tags), title: toDo.title, activityDate: toDo.dueDate ?? Date(), notes: toDo.notes, done: {})
    //
    //       // Activity(activity_date: toDo.due_date ?? Date(), title: toDo.title, image: nil, notes: toDo.notes, created_by: store.value.loggedInUser, tags: toDo.tags, participants: NSSet(array: learners))
    //    }
    
    var body: some View{
        VStack{
            if(!toDo.saved_to_activity){
        NavigationLink(destination:
            ActivityEditableForm(
                store:store.view(
                    value: {$0.activityState},
                    action: {.activity($0)}),
                learnerSelectionManger: GenericSelectionManager(learners.map {$0}),
                tagSelectionManager: GenericSelectionManager(tags),
                title: toDo.title,
                activityDate: toDo.due_date ?? Date(),
                link: toDo.link ?? "",
                notes: toDo.notes ?? "",
                done: {
                    self.store.send(.editSavedToActivity(toDo: self.toDo, saved: true))
            })){
                    
                    
                    Text("Save to Activities")
                        .foregroundColor(.primary)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 80)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
        }.padding(.top, 10)
            } else {
                EmptyView()
//                Text("Saved")
//                .foregroundColor(.primary)
//                .padding()
//                .frame(width: UIScreen.main.bounds.width - 80)
//                .background(Color.green.opacity(0.8))
//                .cornerRadius(20)
//                .padding(.top, 10)
            }
        }
    }
}

struct toDoRow: View {
    @ObservedObject var store: Store<ToDoState, ToDoAction>
    var toDoClicked: (ToDo) -> Void
    @ObservedObject var toDo: ToDo
    @State var localDoneValue : Bool
    
    let seconds = 4.0
    func changeRealDone(){
//        let seconds = 4.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.store.send(.editDone(toDo: self.toDo, done: self.localDoneValue))
            // need to make sure we save the context here, should really be sent as an edit
            
            // Put your code which should be executed with a delay here
//        }
    }
    
    
    var body: some View{
        VStack(alignment: .leading){
            HStack(alignment: .center){
                
                Button(action: {
                    self.localDoneValue.toggle()
                    self.changeRealDone()
                }){
                    ZStack(alignment: .center){
                        Circle()
                            .foregroundColor(localDoneValue ? orangeBright : .clear).frame(width: 25, height: 25)
                        Circle()
                            .stroke(orangeBright, lineWidth: 2)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.clear)
                    }
                }
                Text(toDo.title)
                
                Spacer()
//                if(toDo.saved_to_activity){
//                    Text("Saved")
//                        .foregroundColor(.green)
//                }
                
                Button(action: {
                    self.toDoClicked(self.toDo)
                }){
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.secondary)
                }
            }
            HStack{
            VStack(alignment: .leading){
                if(toDo.due_date != nil){
                    Text(toDoDateFormatter.string(from: toDo.due_date!))
                        .foregroundColor(.secondary)
                } else {
                    EmptyView()
                }
                if(toDo.link != nil){
                    Link(toDo.link!)
                } else {
                    EmptyView()
                }
               
                }
                Spacer()
                               if(localDoneValue){
                                   SaveToActivitiesLink(store: store, toDo: toDo)
                                   //SaveToActivityLink(store: store, toDo: toDo)
                                   
                               }
                
            }.padding(.leading, 35)
            
            
        }
    }
}

struct LearnerToDos: View {
    @ObservedObject var store: Store<ToDoState, ToDoAction>
    var toDoClicked: (ToDo) -> Void
    var toDos: [ToDo]
    
    
    
    var body: some View{
        VStack{
            
            ForEach(toDos){toDo in
                VStack{
                    //ToDoCard(store: self.store, toDo: toDo)
                toDoRow(store: self.store, toDoClicked: self.toDoClicked, toDo: toDo, localDoneValue: toDo.done)
                    .padding(.bottom, 5)
                Divider()
                }
            }
//            .onDelete(perform: { indexSet in
//                for index in indexSet{
//                    AppDelegate.shared.persistentContainer.viewContext.delete(self.toDos[index])
//                }
//            })
            .transition(.scale)
            
        }
    }
}


struct PlanHome: View {
    @ObservedObject var store: Store<ToDoState, ToDoAction>
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.date_created, ascending: false)])
    var toDos: FetchedResults<ToDo>
    
    
    @State var selectedLearner: Learner?
    @State var showModal = false
    @State var modalContent: ToDoCreate? = nil
    
    @State var showDoneSelect = 0
    @State var showDoneOptions = [false, true]
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //    var ObseredToDos: [ObservedToDo] {
    //        toDos.map {
    //            var x = ObservedToDo(toDo: $0)
    //            x.doneTemp = $0.done
    //            return x
    //        }
    //    }
    
    func onToDoClicked(toDo: ToDo){
        self.modalContent = ToDoCreate(store: self.store, toDo: toDo, showModal: self.$showModal)
        self.showModal = true
    }
    
    func newClicked(learner: Learner){
        self.modalContent = ToDoCreate(store: self.store, learner: learner, showModal: self.$showModal)
        self.showModal = true
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
            VStack(alignment: .leading){
                Picker(selection: $showDoneSelect, label: Text("")){
                    Text("Show Undone").tag(0)
                    Text("Show Done").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                
                ForEach(learners){learner in
                    VStack(alignment: .leading){
                        //  Divider()
                        Divider()
                            .frame(height: 3)
                            .padding(.leading, -20)
                            .padding(.trailing, -20)
                        HStack{
                            ProfileImage(learner: learner, size: 30)
                            Text(learner.name).bold().font(.system(size: 22))
                            Button(action: {
                                self.newClicked(learner: learner)
                            }){
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }.padding(.bottom, 10)
                        
                        
                        LearnerToDos(store: self.store, toDoClicked: self.onToDoClicked, toDos:
                            self.toDos.filter {toDo in
                                toDo.learner == learner && (self.showDoneOptions[self.showDoneSelect] ? toDo.done : !toDo.done)
                            }
                        )
                        
                        
                        
                        
                        
                    }.padding(.bottom, 40)
                    
                    
                    
                }
                Spacer()
                
            }.padding(.leading, 10).padding(.trailing, 15)
            }
                .navigationBarTitle("Plan")
                .sheet(isPresented: $showModal) {
                    self.modalContent!.environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
        
    }
}


