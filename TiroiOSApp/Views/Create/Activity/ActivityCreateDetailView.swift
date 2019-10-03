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
    @Binding var image: UIImage?
  
    
    
    var body: some View {
//        MultiPicker()
        VStack{
        if(image == nil){
        ImagePickerViewController(showModal: $showModal, image: $image)
        } else {
            Image(uiImage: image!)
        }
        }
    }
}



struct ActivityEditableForm : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    var activity : Activity?
    @ObservedObject var activityBindable : ActivityBindable
    
    
    @State var image : UIImage? = nil
    @ObservedObject var learnerSelectionManger : MySelectionManager
    @ObservedObject var tagSelectionManager : MySelectionManager
    var done : () -> Void
    
    @State var presentImagePicker : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var participants : [Learner] {
        learnerSelectionManger.selectedAsArray as! [Learner]
    }
    
    
    
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return formatter
    }()
    
    func save() {
        // might be interesting to try handling this in the deinit of the bindable object, but
        // then you'd have to create activity in init and delete if cancelled
        // another idea is to have tthe dinbale activity always be alive inside the NSObject
        
        // maybe they didn't change anythting, so don't save?
        // or always save, and use title from date 
        
        if(image != nil){
            activityBindable.image = image!.jpegData(compressionQuality: 1)
        }
        if(activityBindable.title == ""){
            activityBindable.title = "Activity on " + Self.dateFormatter.string(from: activityBindable.activityDate)
        }
        activityBindable.participants = participants
        activityBindable.tags = tagSelectionManager.selectedAsArray as! [Tag]
        
        if activity != nil {
            mainEnv.saveActivityFromBindable(bindableActivity: activityBindable, activity: activity!)
        } else {
            mainEnv.createActivtyFromBindable(bindable: activityBindable)
        }
        self.showModal = false
        self.presentationMode.wrappedValue.dismiss()
       self.done()
        
        
    }
    
    var body : some View {
        Form{
            Section(header: Text("Title")){
                TextField("Activity on " + Self.dateFormatter.string(from: activityBindable.activityDate), text: $activityBindable.title)
            }
            Section(header : Text("Pick Image")){
                if(activityBindable.image != nil){
                    HStack{
                        DisplayUIImage(uiImageData: activityBindable.image!)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                        Button(action: {self.presentImagePicker = true}){
                                               Text("Change Photo")
                                           }
                    }
                } else if(image != nil) {
                    HStack{
                        DisplayUIImage(uiImageData: image!.jpegData(compressionQuality: 1)!)
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
            }.sheet(isPresented: $presentImagePicker) {
                ImagePicker(showModal: self.$presentImagePicker, image: self.$image)
            }
            
            Section{
                TagSelect(selectionManager: tagSelectionManager)
                NavigationLink(destination: LearnerSelect(selectionManager: learnerSelectionManger)){
                               HStack{
                                   Text("Learners")
                                   if(!participants.isEmpty){
                                       Spacer()
                                       
                                       ForEach(participants){learner in
                                           Text(learner.name)
                                               .foregroundColor(.secondary)
                                       }
                                   }
                               }
                           }
            }
            Section{
           
            DatePicker("Date", selection: $activityBindable.activityDate)
                
                TextField("Notes",  text: $activityBindable.notes)
                               .lineLimit(nil)
           
            
            }
            
            
            
            
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
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    var activity : Activity?
    var done : () -> Void
    
    
    var activityBindable : ActivityBindable {
        if activity != nil {
            return mainEnv.createBindablefromActivity(activity: activity!)
        } else {
            return ActivityBindable(title: "", notes: "", activityDate: Date(), image: nil, participants: [], tags: [])
        }
    }
    
    var participants : [Learner] {
        if activity == nil{
            return []
        } else {
           return activity!.participants!.allObjects as! [Learner]
        }
    }
    
    var tags : [Tag] {
        if activity == nil{
            return []
        } else {
           return activity!.tags!.allObjects as! [Tag]
        }
    }

    var body: some View {
        
        ActivityEditableForm(showModal: $showModal, activity: activity, activityBindable: activityBindable, learnerSelectionManger: MySelectionManager(selected: Set(participants)), tagSelectionManager: MySelectionManager(selected: Set(tags)), done: done)
            .navigationBarTitle("\(activity != nil ? "Edit" : "Create") Activity", displayMode: .inline)
        
        
    }
}

#if DEBUG
//struct ActivityCreateDetailView_Previews : PreviewProvider {
//    @State static var showModal = false
//    static var previews: some View {
//        ActivityCreateDetailView(showModal: $showModal).environmentObject(MainEnvObj())
//    }
//}
#endif
