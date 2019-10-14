//
//  ActivityCreateDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import UIKit
import Combine
//import BSImagePicker
//import Photosu
//import DKImagePickerController
//
class Multi: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

struct MultiPicker: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<MultiPicker>) -> Multi {
        return Multi()
    }
    
    func updateUIViewController(_ uiViewController: Multi, context: UIViewControllerRepresentableContext<MultiPicker>) {
        print("update")
    }
    
    typealias UIViewControllerType = Multi
    
    
    
    
}

struct ImagePicker : View {
    @Binding var showModal: Bool
    @Binding var image: Data?
    @Binding var imageDate: Date
    
    
    
    var body: some View {
        //        MultiPicker()
        VStack{
            //if(image == nil){
            ImagePickerViewController(showModal: $showModal, image: $image, imageDate: $imageDate)
            //}
            
        }
    }
}




struct ActivityEditableForm : View {
    @ObservedObject var store: Store<ActivityState, ActivityAction>
    var activity : Activity?
    @ObservedObject var learnerSelectionManger : GenericSelectionManager<Learner>
    @ObservedObject var tagSelectionManager : GenericSelectionManager<Tag>
    @State var title: String
    
    
    @State var image: Data? = nil
    
    
    @State var activityDate: Date
    // @State var participants: [Learner]
    @State var notes: String
    var done : () -> Void
    
    
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    
    @FetchRequest(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: true)])
    var tags: FetchedResults<Tag>
    
    
    // @ObservedObject var activityBindable : ActivityBindable
    
    
    //@State var image : UIImage? = nil
    @State var imageDate: Date? = nil
    @State var dateHasChange: Bool = false
    
    
    
    
    @State var presentImagePicker : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    
    func save() {
        if(title == ""){
            title = "Activity on " + longDateFormatter.string(from: activityDate)
        }
        //activityBindable.participants = participants
        //activityBindable.tags = tagSelectionManager.selectedAsArray
        
        if activity != nil {
            print("sending edit")
            store.send(.edit(activityDate: activityDate, title: title, image: image, notes: notes, tags: tagSelectionManager.selectedAsArray, participants: learnerSelectionManger.selectedAsArray, activity: activity!))
            // saveActivityFromBindable(bindableActivity: activityBindable, activity: activity!)
        } else {
            store.send(.create(activityDate: activityDate, title: title, image: image, notes: notes, participants: learnerSelectionManger.selectedAsArray))
        }
        self.presentationMode.wrappedValue.dismiss()
        self.done()
        
        
        
    }
    
    var body : some View {
        Form{
            Section{
                TextField("Activity on " + longDateFormatter.string(from: activityDate), text: $title)
                
                if(image != nil){
                    HStack{
                        DisplayUIImage(uiImageData: image!)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                        Button(action: {self.presentImagePicker = true}){
                            Text("Change Photo")
                        }
                    }
                }
                else {
                    Button(action: {self.presentImagePicker = true}){
                        Text("Add Photo")
                    }
                }
                DatePicker("Date", selection: $activityDate)
            }.sheet(isPresented: $presentImagePicker) {
                ImagePicker(showModal: self.$presentImagePicker, image: self.$image, imageDate: self.$activityDate)
            }
            
            Section{
                MultiSelect(title: "tags", selectionManager: tagSelectionManager, choices: tags.map {$0}, getName: {$0.name})
                MultiSelect(title: "learners", selectionManager: learnerSelectionManger, choices: learners.map {$0}, getName: {$0.name})
                
                //Section{
                
                
                
                TextField("Notes",  text: $notes)
                    .lineLimit(nil)
                //                    .multilineTextAlignment(.leading)
                //                    .frame(height: 100)
            }
            
            // }
        }
        .navigationBarItems(
            trailing:
            Button(action: {
                self.save()
                
            }){
                Text("Save")
            }
        )
    }
}

struct ActivityCreateDetailView : View {
    @ObservedObject var store: Store<ActivityState, ActivityAction>
    var activity : Activity?
    var done : () -> Void
    var content: ActivityEditableForm
    
    init(store: Store<ActivityState, ActivityAction>, done: @escaping () -> Void){
        self.store = store
        self.done = done
        self.content = ActivityEditableForm(store: store, activity: nil, learnerSelectionManger: GenericSelectionManager([]), tagSelectionManager: GenericSelectionManager([]), title: "", activityDate: Date(), notes: "", done: self.done)
    }
    
    init(store: Store<ActivityState, ActivityAction>, activity: Activity, done: @escaping () -> Void){
        self.store = store
        self.done = done
        let participants = activity.participants!.allObjects as! [Learner]
        let tags = activity.tags!.allObjects as! [Tag]
        self.content = ActivityEditableForm(store: store, activity: activity, learnerSelectionManger: GenericSelectionManager(participants), tagSelectionManager: GenericSelectionManager(tags), title: activity.title, image: activity.image, activityDate: activity.activity_date, notes: activity.notes ?? "", done: self.done)
    }
    

    var body: some View {
        
        content
            .navigationBarTitle("\(activity != nil ? "Edit" : "Create") Activity", displayMode: .inline)
        
        
    }
}

