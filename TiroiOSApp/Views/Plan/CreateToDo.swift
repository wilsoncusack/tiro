//
//  CreateToDo.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/19/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI


struct toDoFormPart1: View {
    @Binding var title: String
    @Binding var link: String
    @Binding var notes: String
    @ObservedObject var tagSelectionManager : GenericSelectionManager<Tag>
    var tags: [Tag]
    
    var body: some View{
        Section{
            TextField("Title", text: $title)
            TextField("link", text: $link).foregroundColor(.blue)
            TextField("notes", text: $notes)
            MultiSelect(title: "Tags", selectionManager: tagSelectionManager, choices: tags, getName: {tag in tag.name})
        }
    }
    
}

struct ToDoEditable: View{
    @Binding var showModal: Bool
    var store: Store<ToDoState, ToDoAction>
    var toDo: ToDo?
    @State var title: String
    @State var hasDueDate: Bool
    @State var dueDate: Date
    @State var notes: String
    @State var link: String
    @State var learner: Learner? = nil
    @State var sendNotification: Bool
    @State var notificationId: String? = nil
    @ObservedObject var tagSelectionManager : GenericSelectionManager<Tag>
    
    
    @FetchRequest(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: false)])
    var tags: FetchedResults<Tag>
    
    func saveNew(){
        let dateToSend = hasDueDate ? dueDate : nil
        let notesToSend = notes.isEmpty ? nil : notes
        let linkTosend = link.isEmpty ? nil : link
        let notificationCenter = UNUserNotificationCenter.current()
        if(sendNotification && hasDueDate){
            let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dateToSend!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
            
            notificationId = UUID().uuidString
            let content = UNMutableNotificationContent()
            content.title = title
            let request = UNNotificationRequest(identifier: notificationId!,
                                                content: content, trigger: trigger)
            print("setting notification")
            notificationCenter.add(request) { error in
                print("Error in notification: \(error.debugDescription)")
            }
        }
        
        store.send(.create(title: title, due_date: dateToSend, notes: notesToSend, link: linkTosend, learner: learner, notification_id: notificationId, tags: tagSelectionManager.selectedAsArray))
        self.showModal = false
    }
    
    
    func saveEdit(){
        
        let dateToSend = hasDueDate ? dueDate : nil
        let notesToSend = notes.isEmpty ? nil : notes
        let linkTosend = link.isEmpty ? nil : link
        let notificationCenter = UNUserNotificationCenter.current()
        if(sendNotification && hasDueDate){
            if(notificationId != nil){
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId!])
            }
            
            let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dateToSend!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
            
            notificationId = UUID().uuidString
            let content = UNMutableNotificationContent()
            content.title = title
            let request = UNNotificationRequest(identifier: notificationId!,
                                                content: content, trigger: trigger)
            print("setting notification")
            notificationCenter.add(request) { error in
                print("Error in notification: \(error.debugDescription)")
            }
        } else if((!sendNotification || !hasDueDate) && notificationId != nil){
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId!])
        }
        
        store.send(.edit(toDo: toDo!, title: title, due_date: dateToSend, notes: notesToSend, link: linkTosend, done: toDo!.done, learner: learner, notification_id: notificationId, tags: tagSelectionManager.selectedAsArray, saved_to_activity: toDo!.saved_to_activity))
        self.showModal = false
    }
    var body: some View{
        NavigationView{
            Form{
                toDoFormPart1(title: $title, link: $link, notes: $notes, tagSelectionManager: tagSelectionManager, tags: tags.map {$0})
                Section{
                    Toggle("Has Due Date?", isOn: $hasDueDate)
                    if(hasDueDate){
                        DatePicker(selection: $dueDate, in: Date()..., displayedComponents:.date){
                            Text("Due Date")
                        }
                        Toggle("Send Reminder Notification?", isOn: $sendNotification)
                        if(sendNotification){
                            DatePicker(selection: $dueDate, displayedComponents: .hourAndMinute){
                                Text("Send at")
                            }
                        } else {
                            EmptyView()
                        }
                        
                    } else {
                        EmptyView()
                    }
                }
            }
            .navigationBarTitle( Text("New To Do for \(learner!.name)"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if(self.toDo != nil){
                    self.saveEdit()
                } else {
                    self.saveNew()
                }
                
            }){
                Text("Save")
            } )
            
            
            
        }
    }
}

struct ToDoCreate: View {
    var content: ToDoEditable
    
    init(store: Store<ToDoState, ToDoAction>, toDo: ToDo, showModal: Binding<Bool>){
        
    
        let tags = toDo.tags?.allObjects as! [Tag]
        let hasDueDate = toDo.due_date != nil
        //content = nil
        content = ToDoEditable(
            showModal: showModal,
            store: store,
            toDo: toDo,
            title: toDo.title,
            hasDueDate: hasDueDate,
            dueDate: toDo.due_date ?? Date(),
            notes: toDo.notes ?? "",
            link: toDo.link ?? "",
            learner: toDo.learner,
            sendNotification: toDo.notification_id != nil,
            notificationId: toDo.notification_id,
            tagSelectionManager: GenericSelectionManager(tags))
    }
    
    init(store: Store<ToDoState, ToDoAction>, learner: Learner, showModal: Binding<Bool>){
        
        content = ToDoEditable(
            showModal: showModal,
            store: store,
            toDo: nil,
            title: "",
            hasDueDate: false,
            dueDate: Date(),
            notes: "",
            link: "",
            learner: learner,
            sendNotification: false,
            notificationId: nil,
            tagSelectionManager: GenericSelectionManager([]))
    }
    
    var body: some View{
        content
    }
}
